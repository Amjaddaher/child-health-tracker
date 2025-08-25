import '../entities/measurement.dart';

abstract class MeasurementRepository {
  Future<List<Measurement>> getByChild(String childId);

  Future<Measurement> add({
    required String childId,
    required DateTime date,
    double? weight,
    double? height,
    double? headCirc,
  });

  Future<void> delete(String id);
}
