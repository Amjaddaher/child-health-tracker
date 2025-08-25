import 'package:dartz/dartz.dart';
import '../../domain/entities/reminder.dart';
import '../../domain/repositories/reminder_repository.dart';
import '../datasources/reminder_remote_ds.dart';
import '../models/reminder_dto.dart';

class RemindersRepositoryImpl implements RemindersRepository {
  final RemindersRemoteDataSource remote;

  RemindersRepositoryImpl(this.remote);

  @override
  Future<Either<Exception, Reminder>> create(Reminder reminder) async {
    try {
      final dto = ReminderDto.fromEntity(reminder);
      final data = dto.toMap()..remove('id'); // let supabase generate id or keep if needed
      final result = await remote.insertReminder(data);
      final created = ReminderDto.fromMap(result).toEntity();
      return Right(created);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Unit>> delete(int id) async {
    try {
      await remote.deleteReminder(id);
      return const Right(unit);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, List<Reminder>>> getByChild(String childId) async {
    try {
      final rows = await remote.getRemindersByChild(childId);
      final list = rows.map((r) => ReminderDto.fromMap(r).toEntity()).toList();
      return Right(list);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Reminder>> update(Reminder reminder) async {
    try {
      final dto = ReminderDto.fromEntity(reminder);
      final changes = dto.toMap()..remove('id')..remove('user_id')..remove('created_at'); // keep sensible fields
      final result = await remote.updateReminder(reminder.id, changes);
      final updated = ReminderDto.fromMap(result).toEntity();
      return Right(updated);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Reminder>> toggleComplete(int id, {required bool completed}) async {
    try {
      final changes = {
        'is_completed': completed,
        'completed_at': completed ? DateTime.now().toIso8601String() : null,
      };
      final result = await remote.updateReminder(id, changes);
      return Right(ReminderDto.fromMap(result).toEntity());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<Either<Exception, Reminder>> getById(int id) async {
    try {
      final res = await remote.getReminderById(id);
      if (res == null) return Left(Exception('Not found'));
      return Right(ReminderDto.fromMap(res).toEntity());
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}
