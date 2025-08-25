import '../entities/health_record.dart';
import '../repositories/health_record_repository.dart';

class GetHealthRecords {
  final HealthRecordRepository repository;
  GetHealthRecords(this.repository);

  Future<List<HealthRecord>> call(String childId) async {
    return await repository.getRecords(childId);
  }
}
