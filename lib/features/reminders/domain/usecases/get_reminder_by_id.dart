import 'package:dartz/dartz.dart';
import '../entities/reminder.dart';
import '../repositories/reminder_repository.dart';

class GetReminderByIdUseCase {
  final RemindersRepository repository;

  GetReminderByIdUseCase(this.repository);

  Future<Either<Exception, Reminder>> call(int id) async {
    return await repository.getById(id);
  }
}
