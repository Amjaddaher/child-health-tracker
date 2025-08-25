import '../entities/health_record.dart';

abstract class HealthRecordRepository {
  Future<List<HealthRecord>> getRecords(String childId);
  Future<void> addRecord(HealthRecord record);
  // Future<void> updateRecord(HealthRecord record);
  Future<void> deleteRecord(String id); // 🆕
}
