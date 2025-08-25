import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../domain/entities/vaccination.dart';
import '../bloc/vaccine_bloc.dart';
import 'package:doctor/features/vaccinations/presentation/bloc/vaccinations_event.dart';
import 'package:doctor/features/vaccinations/presentation/bloc/vaccinations_state.dart';

class VaccinationsPage extends StatelessWidget {
  final String childId;
  const VaccinationsPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    context.read<VaccinationBloc>().add(LoadVaccinations(childId));

    return Scaffold(
      appBar: AppBar(title: Text('vaccinations.title'.tr)),
      body: BlocListener<VaccinationBloc, VaccinationState>(listener: (context, state) {
        if (state is VaccinationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          context.read<VaccinationBloc>().add(LoadVaccinations(childId));
        } else if (state is VaccinationError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      }, child: BlocBuilder<VaccinationBloc, VaccinationState>(builder: (context, state) {
        if (state is VaccinationLoading) return const Center(child: CircularProgressIndicator());
        if (state is VaccinationLoaded) {
          if (state.vaccinations.isEmpty) return Center(child: Text('vaccinations.no_vaccinations'.tr));
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.vaccinations.length,
            itemBuilder: (context, index) {
              final vaccination = state.vaccinations[index];
              return _VaccinationCard(vaccination: vaccination);
            },
          );
        } else if (state is VaccinationError) {
          return Center(child: Text('common.error_with_message'.trParams({'msg': state.message})));
        }
        return const SizedBox.shrink();
      })),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final vaccination = await showDialog<Vaccination>(context: context, builder: (_) => _AddVaccinationDialog(childId: childId));
        if (vaccination != null && context.mounted) {
          context.read<VaccinationBloc>().add(AddVaccinationEvent(vaccination));
        }
      }, child: const Icon(Icons.add)),
    );
  }
}

class _VaccinationCard extends StatelessWidget {
  final Vaccination vaccination;
  const _VaccinationCard({required this.vaccination});

  @override
  Widget build(BuildContext context) {
    final scheduledText = vaccination.scheduledAt.toLocal().toString();
    final statusText = vaccination.status.name;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text('${vaccination.vaccineName} (Dose ${vaccination.doseNumber})'),
        subtitle: Text('${'vaccinations.scheduled'.trParams({'date': scheduledText})}\n${'vaccinations.status'.trParams({'status': statusText})}'),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'mark') {
              context.read<VaccinationBloc>().add(MarkAdministeredEvent(vaccination.id!, DateTime.now()));
            } else if (value == 'delete') {
              context.read<VaccinationBloc>().add(DeleteVaccinationEvent(vaccination.id!));
            }
          },
          itemBuilder: (context) => [
            if (vaccination.administeredAt == null) PopupMenuItem(value: 'mark', child: Text('vaccinations.mark_administered'.tr)),
            PopupMenuItem(value: 'delete', child: Text('vaccinations.delete'.tr)),
          ],
        ),
      ),
    );
  }
}

class _AddVaccinationDialog extends StatefulWidget {
  final String childId;
  const _AddVaccinationDialog({required this.childId});

  @override
  State<_AddVaccinationDialog> createState() => _AddVaccinationDialogState();
}

class _AddVaccinationDialogState extends State<_AddVaccinationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _doseController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _scheduledAt;

  @override
  Widget build(BuildContext context) {
    final scheduledText = _scheduledAt != null ? _scheduledAt!.toLocal().toString() : 'vaccinations.no_date_chosen'.tr;
    return AlertDialog(
      title: Text('vaccinations.add_vaccination'.tr),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(controller: _nameController, decoration: InputDecoration(labelText: 'vaccinations.vaccine_name'.tr), validator: (value) => value == null || value.isEmpty ? 'vaccinations.enter_name'.tr : null),
            const SizedBox(height: 12),
            TextFormField(controller: _doseController, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: 'vaccinations.dose_number'.tr), validator: (value) => value == null || value.isEmpty ? 'vaccinations.enter_dose'.tr : null),
            const SizedBox(height: 12),
            TextFormField(controller: _locationController, decoration: InputDecoration(labelText: 'vaccinations.location_optional'.tr)),
            const SizedBox(height: 12),
            TextFormField(controller: _notesController, decoration: InputDecoration(labelText: 'vaccinations.notes_optional'.tr)),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: Text(_scheduledAt != null ? 'vaccinations.scheduled'.trParams({'date': scheduledText}) : 'vaccinations.no_date_chosen'.tr)),
              IconButton(icon: const Icon(Icons.calendar_today), onPressed: () async {
                final now = DateTime.now();
                final picked = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(now.year - 1), lastDate: DateTime(now.year + 5));
                if (picked != null) setState(() => _scheduledAt = picked);
              })
            ]),
          ]),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('common.cancel'.tr)),
        ElevatedButton(onPressed: () {
          if (_formKey.currentState?.validate() == true && _scheduledAt != null) {
            final vaccination = Vaccination(
              id: '',
              childId: widget.childId,
              vaccineName: _nameController.text,
              doseNumber: int.parse(_doseController.text),
              scheduledAt: _scheduledAt!,
              administeredAt: null,
              location: _locationController.text.isNotEmpty ? _locationController.text : null,
              notes: _notesController.text.isNotEmpty ? _notesController.text : null,
              status: VaccinationStatus.scheduled,
            );
            Navigator.pop(context, vaccination);
          }
        }, child: Text('vaccinations.add'.tr)),
      ],
    );
  }
}
