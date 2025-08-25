import 'package:equatable/equatable.dart';
import '../../domain/entities/health_record.dart';

abstract class HealthRecordState extends Equatable {
  const HealthRecordState();

  @override
  List<Object?> get props => [];
}

class HealthRecordInitial extends HealthRecordState {}

class RecordsLoading extends HealthRecordState {}

class RecordsLoaded extends HealthRecordState {
  final List<HealthRecord> records;
  const RecordsLoaded(this.records);

  @override
  List<Object?> get props => [records];
}

class RecordsError extends HealthRecordState {
  final String message;
  const RecordsError(this.message);

  @override
  List<Object?> get props => [message];
}
