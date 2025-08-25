import 'package:dartz/dartz.dart';
import '../repositories/reminder_repository.dart';

class DeleteReminder {
  final RemindersRepository repository;
  DeleteReminder(this.repository);

  Future<Either<Exception, Unit>> call(int id) {
    return repository.delete(id);
  }
}
