import 'package:dartz/dartz.dart';
import '../entities/reminder.dart';
import '../repositories/reminder_repository.dart';

class GetRemindersByChildUseCase {
  final RemindersRepository repository;

  GetRemindersByChildUseCase(this.repository);

  Future<Either<Exception, List<Reminder>>> call(String childId) async {
    return await repository.getByChild(childId);
  }
}
