import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../domain/entities/health_record.dart';
import '../bloc/health_record_bloc.dart';
import '../bloc/health_record_event.dart';

class HealthRecordFormPage extends StatefulWidget {
  final String childId;
  const HealthRecordFormPage({super.key, required this.childId});

  @override
  State<HealthRecordFormPage> createState() => _HealthRecordFormPageState();
}

class _HealthRecordFormPageState extends State<HealthRecordFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _detailsCtrl;

  @override
  void initState() {
    super.initState();
    _detailsCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _detailsCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final record = HealthRecord(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        childId: widget.childId,
        date: DateTime.now(),
        details: _detailsCtrl.text.trim(),
        createdAt: DateTime.now(),
      );
      context.read<HealthRecordBloc>().add(AddRecord(record));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('health_record.appbar'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: _detailsCtrl,
              decoration: InputDecoration(labelText: 'health_record.title_label'.tr),
              maxLines: 3,
              validator: (val) => val == null || val.isEmpty ? 'health_record.required'.tr : null,
            ),
            const Spacer(),
            SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: _submit, icon: const Icon(Icons.save), label: Text('health_record.add_button'.tr))),
          ]),
        ),
      ),
    );
  }
}
