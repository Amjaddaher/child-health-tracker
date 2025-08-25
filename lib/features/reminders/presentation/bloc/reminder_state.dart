import 'package:equatable/equatable.dart';
import '../../domain/entities/reminder.dart';

abstract class RemindersState extends Equatable {
  const RemindersState();
  @override
  List<Object?> get props => [];
}

class RemindersInitial extends RemindersState {
  const RemindersInitial();
}

class RemindersLoading extends RemindersState {
  const RemindersLoading();
}

class RemindersLoaded extends RemindersState {
  final List<Reminder> reminders;
  const RemindersLoaded(this.reminders);
  @override
  List<Object?> get props => [reminders];
}

class ReminderOperationSuccess extends RemindersState {
  final Reminder reminder;
  const ReminderOperationSuccess(this.reminder);
  @override
  List<Object?> get props => [reminder];
}

class RemindersError extends RemindersState {
  final String message;
  const RemindersError(this.message);
  @override
  List<Object?> get props => [message];
}
