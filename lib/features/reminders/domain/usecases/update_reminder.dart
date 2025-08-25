import 'package:dartz/dartz.dart';
import '../entities/reminder.dart';
import '../repositories/reminder_repository.dart';

class UpdateReminder {
  final RemindersRepository repository;
  UpdateReminder(this.repository);

  Future<Either<Exception, Reminder>> call(Reminder reminder) {
    return repository.update(reminder);
  }
}
