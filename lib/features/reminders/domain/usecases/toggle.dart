import 'package:dartz/dartz.dart';
import '../entities/reminder.dart';
import '../repositories/reminder_repository.dart';

class ToggleCompleteReminderUseCase {
  final RemindersRepository repository;

  ToggleCompleteReminderUseCase(this.repository);

  Future<Either<Exception, Reminder>> call(int id, bool completed) async {
    return await repository.toggleComplete(id, completed: completed);
  }
}
