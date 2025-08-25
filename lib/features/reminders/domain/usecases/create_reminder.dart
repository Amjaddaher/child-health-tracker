import 'package:dartz/dartz.dart';
import '../entities/reminder.dart';
import '../repositories/reminder_repository.dart';

class CreateReminder {
  final RemindersRepository repository;
  CreateReminder(this.repository);

  Future<Either<Exception, Reminder>> call(Reminder reminder) {
    return repository.create(reminder);
  }
}
