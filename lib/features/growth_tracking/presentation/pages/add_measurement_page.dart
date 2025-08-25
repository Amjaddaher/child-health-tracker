import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../bloc/measurement_bloc.dart';
import '../bloc/measurement_event.dart';

class AddMeasurementPage extends StatefulWidget {
  final String childId;
  const AddMeasurementPage({super.key, required this.childId});

  @override
  State<AddMeasurementPage> createState() => _AddMeasurementPageState();
}

class _AddMeasurementPageState extends State<AddMeasurementPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime _date = DateTime.now();
  final _weight = TextEditingController();
  final _height = TextEditingController();
  final _head = TextEditingController();

  @override
  void dispose() {
    _weight.dispose();
    _height.dispose();
    _head.dispose();
    super.dispose();
  }

  String? _decimalValidator(String? v) {
    if (v == null || v.trim().isEmpty) return null;
    final parsed = double.tryParse(v);
    if (parsed == null) return 'add_measurement.invalid_number'.tr;
    if (parsed < 0) return 'add_measurement.negative_number'.tr;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add_measurement.title'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('add_measurement.date'.tr),
              subtitle: Text('${_date.toLocal()}'.split(' ').first),
              trailing: IconButton(icon: const Icon(Icons.calendar_today), onPressed: () async {
                final picked = await showDatePicker(context: context, firstDate: DateTime(2010), lastDate: DateTime(2100), initialDate: _date);
                if (picked != null) setState(() => _date = picked);
              }),
            ),
            const SizedBox(height: 8),
            TextFormField(controller: _weight, decoration: InputDecoration(labelText: 'add_measurement.weight_label'.tr, hintText: 'add_measurement.weight_hint'.tr), keyboardType: const TextInputType.numberWithOptions(decimal: true), validator: _decimalValidator),
            const SizedBox(height: 12),
            TextFormField(controller: _height, decoration: InputDecoration(labelText: 'add_measurement.height_label'.tr, hintText: 'add_measurement.height_hint'.tr), keyboardType: const TextInputType.numberWithOptions(decimal: true), validator: _decimalValidator),
            const SizedBox(height: 12),
            TextFormField(controller: _head, decoration: InputDecoration(labelText: 'add_measurement.head_label'.tr, hintText: 'add_measurement.head_hint'.tr), keyboardType: const TextInputType.numberWithOptions(decimal: true), validator: _decimalValidator),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(icon: const Icon(Icons.save), label: Text('add_measurement.save'.tr), onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                context.read<MeasurementBloc>().add(CreateMeasurement(
                  childId: widget.childId,
                  date: _date,
                  weight: _weight.text.isEmpty ? null : double.tryParse(_weight.text),
                  height: _height.text.isEmpty ? null : double.tryParse(_height.text),
                  headCirc: _head.text.isEmpty ? null : double.tryParse(_head.text),
                ));
                Navigator.of(context).pop();
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
