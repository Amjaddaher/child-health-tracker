import 'package:equatable/equatable.dart';

abstract class MeasurementEvent extends Equatable {
  const MeasurementEvent();
  @override
  List<Object?> get props => [];
}

class LoadMeasurements extends MeasurementEvent {
  final String childId;
  const LoadMeasurements(this.childId);
  @override
  List<Object?> get props => [childId];
}

class CreateMeasurement extends MeasurementEvent {
  final String childId;
  final DateTime date;
  final double? weight;
  final double? height;
  final double? headCirc;

  const CreateMeasurement({
    required this.childId,
    required this.date,
    this.weight,
    this.height,
    this.headCirc,
  });

  @override
  List<Object?> get props => [childId, date, weight, height, headCirc];
}

class RemoveMeasurement extends MeasurementEvent {
  final String id;
  final String childId; // for refreshing
  const RemoveMeasurement({required this.id, required this.childId});
  @override
  List<Object?> get props => [id, childId];
}
