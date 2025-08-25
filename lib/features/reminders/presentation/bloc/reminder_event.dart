import 'package:equatable/equatable.dart';
import '../../domain/entities/reminder.dart';

abstract class RemindersEvent extends Equatable {
  const RemindersEvent();
  @override
  List<Object?> get props => [];
}

class RemindersFetch extends RemindersEvent {
  final String childId;
  const RemindersFetch(this.childId);
  @override
  List<Object?> get props => [childId];
}

class RemindersCreate extends RemindersEvent {
  final Reminder reminder;
  const RemindersCreate(this.reminder);
  @override
  List<Object?> get props => [reminder];
}

class RemindersUpdate extends RemindersEvent {
  final Reminder reminder;
  const RemindersUpdate(this.reminder);
  @override
  List<Object?> get props => [reminder];
}

class RemindersDelete extends RemindersEvent {
  final int id;
  const RemindersDelete(this.id);
  @override
  List<Object?> get props => [id];
}

class RemindersToggleComplete extends RemindersEvent {
  final int id;
  final bool completed;
  const RemindersToggleComplete({required this.id, required this.completed});
  @override
  List<Object?> get props => [id, completed];
}

class RemindersGetById extends RemindersEvent {
  final int id;
  const RemindersGetById(this.id);
  @override
  List<Object?> get props => [id];
}
