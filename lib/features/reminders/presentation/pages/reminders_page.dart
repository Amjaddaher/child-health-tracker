import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../domain/entities/reminder.dart' as domain;
import '../bloc/reminder_bloc.dart';
import '../bloc/reminder_event.dart';
import '../bloc/reminder_state.dart';
import '../widgets/reminder_form.dart';

class RemindersPage extends StatelessWidget {
  final String childId;
  const RemindersPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('reminders.title'.tr)),
      body: BlocBuilder<RemindersBloc, RemindersState>(builder: (context, state) {
        if (state is RemindersLoading) return const Center(child: CircularProgressIndicator());
        if (state is RemindersError) return Center(child: Text('common.error_with_message'.trParams({'msg': state.message})));
        if (state is RemindersLoaded) {
          final reminders = state.reminders;
          if (reminders.isEmpty) return Center(child: Text('reminders.no_reminders'.tr));
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: reminders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) {
              final r = reminders[i];
              final createdAt = r.createdAt.toLocal().toString();
              final dueAt = r.dueAt.toLocal().toString();
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Expanded(child: Text(r.title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
                      PopupMenuButton<String>(
                        onSelected: (action) => _onActionSelected(context, action, r),
                        itemBuilder: (_) => [
                          PopupMenuItem(value: 'edit', child: Text('popup.edit'.tr)),
                          PopupMenuItem(value: 'delete', child: Text('popup.delete'.tr)),
                        ],
                      )
                    ]),
                    if (r.notes?.isNotEmpty ?? false) ...[ const SizedBox(height: 8), Text(r.notes!, style: Theme.of(context).textTheme.bodyMedium) ],
                    const SizedBox(height: 12),
                    Column(children: [
                      Text('Created: $createdAt', style: Theme.of(context).textTheme.bodySmall),
                      Text('Due: $dueAt', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                    ]),
                  ]),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      }),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await showDialog(context: context, builder: (_) => ReminderFormDialog(childId: childId));
        if (context.mounted) context.read<RemindersBloc>().add(RemindersFetch(childId));
      }, child: const Icon(Icons.add)),
    );
  }

  void _onActionSelected(BuildContext context, String action, domain.Reminder r) {
    final bloc = context.read<RemindersBloc>();
    switch (action) {
      case 'edit':
        showDialog(context: context, builder: (_) => ReminderFormDialog(childId: r.childId, initialReminder: r)).then((_) {
          if (context.mounted) bloc.add(RemindersFetch(r.childId));
        });
        break;
      case 'delete':
        bloc.add(RemindersDelete(r.id));
        break;
      case 'complete':
        bloc.add(RemindersToggleComplete(id: r.id, completed: true));
        break;
      case 'uncomplete':
        bloc.add(RemindersToggleComplete(id: r.id, completed: false));
        break;
    }
  }
}
