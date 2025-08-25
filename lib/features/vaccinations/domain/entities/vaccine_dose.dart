import 'package:equatable/equatable.dart';

enum VaccinationStatus { scheduled, administered, missed }

class Vaccination extends Equatable {
  final String id;
  final String userId;
  final String childId;
  final String vaccineCode;
  final int doseNumber;
  final DateTime? scheduledDate;
  final VaccinationStatus status;
  final DateTime? administeredDate;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Vaccination({
    required this.id,
    required this.userId,
    required this.childId,
    required this.vaccineCode,
    required this.doseNumber,
    this.scheduledDate,
    this.status = VaccinationStatus.scheduled,
    this.administeredDate,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    childId,
    vaccineCode,
    doseNumber,
    scheduledDate,
    status,
    administeredDate,
    notes,
    createdAt,
    updatedAt,
  ];
}
