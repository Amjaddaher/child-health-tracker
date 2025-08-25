import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/vaccination_model.dart';

abstract class VaccinationRemoteDataSource {
  Future<List<VaccinationModel>> getVaccinations(String childId);

  Future<VaccinationModel> addVaccination(VaccinationModel model);

  Future<VaccinationModel> updateVaccination(VaccinationModel model);

  Future<void> deleteVaccination(String id);

  Future<VaccinationModel> markAdministered(String id, DateTime administeredAt);
}

class SupabaseVaccinationRemoteDataSource
    implements VaccinationRemoteDataSource {
  final SupabaseClient client;

  SupabaseVaccinationRemoteDataSource(this.client);

  static const _table = 'vaccinations';

  @override
  Future<List<VaccinationModel>> getVaccinations(String childId) async {
    final res = await client
        .from(_table)
        .select()
        .eq('child_id', childId)
        .order('scheduled_at');
    return (res as List)
        .map((e) => VaccinationModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<VaccinationModel> addVaccination(VaccinationModel model) async {
    try {
      final res = await client
          .from(_table)
          .insert(model.toMap())
          .select()
          .single();
      print(model.toMap());
      return VaccinationModel.fromMap(Map<String, dynamic>.from(res));
    } catch (e) {
      print(model.toMap());
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<VaccinationModel> updateVaccination(VaccinationModel model) async {
    final res = await client
        .from(_table)
        .update(model.toMap())
        .eq('id', model.id!)
        .select()
        .single();
    return VaccinationModel.fromMap(Map<String, dynamic>.from(res));
  }

  @override
  Future<void> deleteVaccination(String id) async {
    await client.from(_table).delete().eq('id', id);
  }

  @override
  Future<VaccinationModel> markAdministered(
    String id,
    DateTime administeredAt,
  ) async {
    final res = await client
        .from(_table)
        .update({
          'administered_at': administeredAt.toIso8601String(),
          'status': 'administered',
        })
        .eq('id', id)
        .select()
        .single();
    return VaccinationModel.fromMap(Map<String, dynamic>.from(res));
  }
}
