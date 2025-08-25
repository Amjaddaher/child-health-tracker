import '../../domain/entities/measurement.dart';
import '../../domain/repositories/measurement_repository.dart';
import '../datasources/measurement_remote_ds.dart';
import '../models/measurement_model.dart';

class MeasurementRepositoryImpl implements MeasurementRepository {
  final MeasurementRemoteDataSource remote;
  MeasurementRepositoryImpl(this.remote);

  @override
  Future<Measurement> add({
    required String childId,
    required DateTime date,
    double? weight,
    double? height,
    double? headCirc,
  }) {
    // id is returned by Supabase; we put a placeholder for the model ctor
    final model = MeasurementModel(
      id: 'temp',
      childId: childId,
      date: date,
      weight: weight,
      height: height,
      headCirc: headCirc,
    );
    return remote.add(model);
  }

  @override
  Future<void> delete(String id) => remote.delete(id);

  @override
  Future<List<Measurement>> getByChild(String childId) =>
      remote.getByChild(childId);
}
