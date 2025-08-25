import 'package:equatable/equatable.dart';
import '../../domain/entities/measurement.dart';

abstract class MeasurementState extends Equatable {
  const MeasurementState();
  @override
  List<Object?> get props => [];
}

class MeasurementInitial extends MeasurementState {}

class MeasurementLoading extends MeasurementState {}

class MeasurementLoaded extends MeasurementState {
  final List<Measurement> items;
  const MeasurementLoaded(this.items);
  @override
  List<Object?> get props => [items];
}

class MeasurementError extends MeasurementState {
  final String message;
  const MeasurementError(this.message);
  @override
  List<Object?> get props => [message];
}
