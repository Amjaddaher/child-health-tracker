import 'package:dartz/dartz.dart';
import '../entities/reminder.dart';

abstract class RemindersRepository {
  Future<Either<Exception, Reminder>> create(Reminder reminder);
  Future<Either<Exception, Reminder>> update(Reminder reminder);
  Future<Either<Exception, Unit>> delete(int id);
  Future<Either<Exception, List<Reminder>>> getByChild(String childId);
  Future<Either<Exception, Reminder>> toggleComplete(int id, {required bool completed});
  Future<Either<Exception, Reminder>> getById(int id);
}
