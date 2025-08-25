import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_measurement.dart';
import 'measurement_event.dart';
import 'measurement_state.dart';
import '../../domain/usecases/add_measurement.dart';
import '../../domain/usecases/delete_measurement.dart';

class MeasurementBloc extends Bloc<MeasurementEvent, MeasurementState> {
  final GetMeasurements getMeasurements;
  final AddMeasurement addMeasurement;
  final DeleteMeasurement deleteMeasurement;

  MeasurementBloc({
    required this.getMeasurements,
    required this.addMeasurement,
    required this.deleteMeasurement,
  }) : super(MeasurementInitial()) {
    on<LoadMeasurements>(_onLoad);
    on<CreateMeasurement>(_onCreate);
    on<RemoveMeasurement>(_onRemove);
  }

  Future<void> _onLoad(
      LoadMeasurements e,
      Emitter<MeasurementState> emit,
      ) async {
    emit(MeasurementLoading());
    try {
      final list = await getMeasurements(e.childId);
      emit(MeasurementLoaded(list));
    } catch (err) {
      emit(MeasurementError(err.toString()));
    }
  }

  Future<void> _onCreate(
      CreateMeasurement e,
      Emitter<MeasurementState> emit,
      ) async {
    try {
      await addMeasurement(AddMeasurementParams(
        childId: e.childId,
        date: e.date,
        weight: e.weight,
        height: e.height,
        headCirc: e.headCirc,
      ));
      add(LoadMeasurements(e.childId));
    } catch (err) {
      emit(MeasurementError(err.toString()));
    }
  }

  Future<void> _onRemove(
      RemoveMeasurement e,
      Emitter<MeasurementState> emit,
      ) async {
    try {
      await deleteMeasurement(e.id);
      add(LoadMeasurements(e.childId));
    } catch (err) {
      emit(MeasurementError(err.toString()));
    }
  }
}
