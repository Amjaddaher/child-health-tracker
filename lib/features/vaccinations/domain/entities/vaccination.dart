import 'package:equatable/equatable.dart';

enum VaccinationStatus { scheduled, administered, missed }

class Vaccination extends Equatable {
  final String? id;
  final String childId;
  final String vaccineName;
  final int doseNumber;
  final DateTime scheduledAt;
  final DateTime? administeredAt;
  final String? location;
  final String? notes;
  final VaccinationStatus status;

  const Vaccination({
     this.id,
    required this.childId,
    required this.vaccineName,
    required this.doseNumber,
    required this.scheduledAt,
    this.administeredAt,
    this.location,
    this.notes,
    this.status = VaccinationStatus.scheduled,
  });

  Vaccination copyWith({
    String? id,
    String? childId,
    String? vaccineName,
    int? doseNumber,
    DateTime? scheduledAt,
    DateTime? administeredAt,
    String? location,
    String? notes,
    VaccinationStatus? status,
  }) {
    return Vaccination(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      vaccineName: vaccineName ?? this.vaccineName,
      doseNumber: doseNumber ?? this.doseNumber,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      administeredAt: administeredAt ?? this.administeredAt,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    id,
    childId,
    vaccineName,
    doseNumber,
    scheduledAt,
    administeredAt,
    location,
    notes,
    status,
  ];
}
