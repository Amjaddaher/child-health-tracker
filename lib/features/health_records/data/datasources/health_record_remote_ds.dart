import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/health_visit_model.dart';

abstract class HealthRecordRemoteDataSource {
  Future<List<HealthRecordModel>> getHealthRecords(String childId);
  Future<void> addHealthRecord(HealthRecordModel record);
  Future<void> deleteRecord(String id); // 🆕

}

class HealthRecordRemoteDataSourceImpl implements HealthRecordRemoteDataSource {
  final SupabaseClient client;

  HealthRecordRemoteDataSourceImpl(this.client);

  @override
  Future<List<HealthRecordModel>> getHealthRecords(String childId) async {
    final response = await client
        .from('health_record')
        .select()
        .eq('child_id', childId)
        .order('date', ascending: false);

    return (response as List)
        .map((map) => HealthRecordModel.fromMap(map))
        .toList();
  }

  @override
  Future<void> addHealthRecord(HealthRecordModel record) async {
    await client.from('health_record').insert(record.toMap());
  }
  @override
  Future<void> deleteRecord(String id) async {
    await client.from('health_record').delete().eq('id', id);
  }
}
