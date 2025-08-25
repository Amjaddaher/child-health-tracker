import '../../domain/entities/health_record.dart';
import '../../domain/repositories/health_record_repository.dart';
import '../datasources/health_record_remote_ds.dart';
import '../models/health_visit_model.dart';

class HealthRecordRepositoryImpl implements HealthRecordRepository {
  final HealthRecordRemoteDataSource remoteDataSource;

  HealthRecordRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<HealthRecord>> getRecords(String childId) async {
    return await remoteDataSource.getHealthRecords(childId);
  }

  @override
  Future<void> addRecord(HealthRecord record) async {
    final model = HealthRecordModel(
      id: record.id,
      childId: record.childId,
      date: record.date,
      details: record.details,
      createdAt: record.createdAt,

    );
    await remoteDataSource.addHealthRecord(model);
  }
  @override
  Future<void> deleteRecord(String id) {
    return remoteDataSource.deleteRecord(id);
  }




}
