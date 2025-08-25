import '../repositories/measurement_repository.dart';

class DeleteMeasurement {
  final MeasurementRepository repo;
  DeleteMeasurement(this.repo);

  Future<void> call(String id) => repo.delete(id);
}
