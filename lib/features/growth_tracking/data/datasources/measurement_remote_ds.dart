import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/measurement_model.dart';

abstract class MeasurementRemoteDataSource {
  Future<List<MeasurementModel>> getByChild(String childId);
  Future<MeasurementModel> add(MeasurementModel model);
  Future<void> delete(String id);
}

class MeasurementRemoteDataSourceImpl implements MeasurementRemoteDataSource {
  final SupabaseClient client;
  MeasurementRemoteDataSourceImpl(this.client);

  @override
  Future<List<MeasurementModel>> getByChild(String childId) async {
    final res = await client
        .from('measurements')
        .select()
        .eq('child_id', childId)
        .order('date', ascending: true);

    return (res as List)
        .map((e) => MeasurementModel.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<MeasurementModel> add(MeasurementModel model) async {
  try{  final inserted = await client
      .from('measurements')
      .insert({
    'child_id': model.childId,
    'date': model.date.toIso8601String(),
    'weight': model.weight,
    'height': model.height,
    'head_circ': model.headCirc,
  })
      .select()
      .single();

  return MeasurementModel.fromMap(inserted);}
  catch(e){
    print(e);
    throw Exception(e);
  }
  }

  @override
  Future<void> delete(String id) async {
    await client.from('measurements').delete().eq('id', id);
  }
}
