import '../entities/health_record.dart';
import '../repositories/health_record_repository.dart';

class AddHealthRecord {
  final HealthRecordRepository repository;
  AddHealthRecord(this.repository);

  Future<void> call(HealthRecord record) async {
    return await repository.addRecord(record);
  }
}
