import '../entities/measurement.dart';
import '../repositories/measurement_repository.dart';

class GetMeasurements {
  final MeasurementRepository repo;
  GetMeasurements(this.repo);

  Future<List<Measurement>> call(String childId) => repo.getByChild(childId);
}
