import '../entities/measurement.dart';
import '../repositories/measurement_repository.dart';

class AddMeasurementParams {
  final String childId;
  final DateTime date;
  final double? weight;
  final double? height;
  final double? headCirc;

  const AddMeasurementParams({
    required this.childId,
    required this.date,
    this.weight,
    this.height,
    this.headCirc,
  });
}

class AddMeasurement {
  final MeasurementRepository repo;
  AddMeasurement(this.repo);

  Future<Measurement> call(AddMeasurementParams p) => repo.add(
    childId: p.childId,
    date: p.date,
    weight: p.weight,
    height: p.height,
    headCirc: p.headCirc,
  );
}
