import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../health_records/domain/usecases/add_visit.dart';
import '../../../health_records/domain/usecases/delete_visit.dart';
import '../../../health_records/domain/usecases/get_visits.dart';

import '../../../health_records/presentation/bloc/health_record_event.dart';
import '../../../health_records/presentation/bloc/health_record_state.dart';

class HealthRecordBloc extends Bloc<HealthRecordEvent, HealthRecordState> {
  final GetHealthRecords getHealthRecords;
  final AddHealthRecord addHealthRecord;
  final DeleteHealthRecord deleteHealthRecord;

  HealthRecordBloc({
    required this.getHealthRecords,
    required this.addHealthRecord,
    required this.deleteHealthRecord,
  }) : super(HealthRecordInitial()) {
    on<LoadRecords>(_onLoadRecords);
    on<AddRecord>(_onAddRecord);
    on<DeleteRecord>(_onDeleteRecord);
  }

  Future<void> _onLoadRecords(
      LoadRecords event, Emitter<HealthRecordState> emit) async {
    emit(RecordsLoading());
    try {
      final records = await getHealthRecords(event.childId);
      emit(RecordsLoaded(records));
    } catch (e) {
      emit(RecordsError(e.toString()));
    }
  }

  Future<void> _onAddRecord(
      AddRecord event, Emitter<HealthRecordState> emit) async {
    try {
      await addHealthRecord(event.record);
      add(LoadRecords(event.record.childId));
    } catch (e) {
      emit(const RecordsError("Failed to add record"));
    }
  }

  Future<void> _onDeleteRecord(
      DeleteRecord event, Emitter<HealthRecordState> emit) async {
    try {
      await deleteHealthRecord(event.id);
      add(LoadRecords(event.childId));
    } catch (e) {
      emit(const RecordsError("Failed to delete record"));
    }
  }
}
