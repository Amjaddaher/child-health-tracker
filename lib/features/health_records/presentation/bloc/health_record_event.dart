import 'package:equatable/equatable.dart';
import '../../domain/entities/health_record.dart';

abstract class HealthRecordEvent extends Equatable {
  const HealthRecordEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecords extends HealthRecordEvent {
  final String childId;
  const LoadRecords(this.childId);

  @override
  List<Object?> get props => [childId];
}

class AddRecord extends HealthRecordEvent {
  final HealthRecord record;
  const AddRecord(this.record);

  @override
  List<Object?> get props => [record];
}

class DeleteRecord extends HealthRecordEvent {
  final String id;
  final String childId;
  const DeleteRecord(this.id, this.childId);

  @override
  List<Object?> get props => [id, childId];
}
