import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/reminder.dart' as domain;
import '../bloc/reminder_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reminder_event.dart';

class ReminderFormDialog extends StatefulWidget {
  final String childId;
  final domain.Reminder? initialReminder;

  const ReminderFormDialog(
      {Key? key, required this.childId, this.initialReminder})
      : super(key: key);

  @override
  State<ReminderFormDialog> createState() => _ReminderFormDialogState();
}

class _ReminderFormDialogState extends State<ReminderFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _notesCtrl;
  DateTime? _dueAt;

  domain.Reminder? get initial => widget.initialReminder;

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: initial?.title ?? '');
    _notesCtrl = TextEditingController(text: initial?.notes ?? '');
    _dueAt = initial?.dueAt ?? DateTime.now().add(const Duration(hours: 1));
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleText = initial == null
        ? 'reminders.new_title'.tr
        : 'reminders.edit_title'.tr;
    final dueText = _dueAt != null
        ? _dueAt!.toLocal().toString()
        : 'common.no_date_chosen'.tr;
    return AlertDialog(
      title: Text(titleText),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(controller: _titleCtrl,
                decoration: InputDecoration(
                    labelText: 'reminder_form.title_label'.tr),
                validator: (v) =>
                (v == null || v
                    .trim()
                    .isEmpty) ? 'reminder_form.required'.tr : null),
            const SizedBox(height: 8),
            TextFormField(controller: _notesCtrl,
                decoration: InputDecoration(
                    labelText: 'reminder_form.notes_label'.tr),
                minLines: 1,
                maxLines: 4),
            const SizedBox(height: 8),
            Row(children: [
              Expanded(
                  child: Text('reminders.due'.trParams({'date': dueText}))),
              TextButton(onPressed: _pickDateTime,
                  child: Text('reminder_form.change'.tr)),
            ]),
          ]),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(),
            child: Text('reminder_form.cancel'.tr)),
        ElevatedButton(
            onPressed: _onSave, child: Text('reminder_form.save'.tr)),
      ],
    );
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(context: context,
        initialDate: _dueAt ?? DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
        lastDate: DateTime.now().add(const Duration(days: 365 * 5))
    );
    if (date == null) return;
    final time = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(_dueAt ?? DateTime.now()));
    if (time == null) return;
    setState(() { _dueAt = DateTime(date.year, date.month, date.day, time.hour, time.minute); });
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;
    final bloc = context.read<RemindersBloc>();
    final newReminder = domain.Reminder(
      id: 0,
      childId: widget.childId,
      title: _titleCtrl.text.trim(),
      notes: _notesCtrl.text
          .trim()
          .isEmpty ? null : _notesCtrl.text.trim(),
      dueAt: _dueAt!,
      createdAt: initial?.createdAt ?? DateTime.now(),
    );
    if (initial == null)
      bloc.add(RemindersCreate(newReminder));
    else
      bloc.add(RemindersUpdate(newReminder));
    Navigator.of(context).pop();
  }
}
