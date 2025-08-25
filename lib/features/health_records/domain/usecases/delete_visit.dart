import '../repositories/health_record_repository.dart';

class DeleteHealthRecord {
  final HealthRecordRepository repository;
  DeleteHealthRecord(this.repository);

  Future<void> call(String id) {
    return repository.deleteRecord(id);
  }
}
