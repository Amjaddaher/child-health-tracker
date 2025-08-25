

import '../../domain/entities/vaccination.dart';


class VaccinationModel extends Vaccination {
  const VaccinationModel({
     super.id,
    required super.childId,
    required super.vaccineName,
    required super.doseNumber,
    required super.scheduledAt,
    super.administeredAt,
    super.location,
    super.notes,
    super.status,
  });


  factory VaccinationModel.fromMap(Map<String, dynamic> map) {
    return VaccinationModel(
      id: map['id'] as String,
      childId: map['child_id'] as String,
      vaccineName: map['vaccine_name'] as String,
      doseNumber: map['dose_number'] as int,
      scheduledAt: DateTime.parse(map['scheduled_at'] as String),
      administeredAt: map['administered_at'] != null ? DateTime.parse(map['administered_at'] as String) : null,
      location: map['location'] as String?,
      notes: map['notes'] as String?,
      status: _statusFromString(map['status'] as String?),
    );
  }


  Map<String, dynamic> toMap() => {
    // 'id': id,
    'child_id': childId,
    'vaccine_name': vaccineName,
    'dose_number': doseNumber,
    'scheduled_at': scheduledAt.toIso8601String(),
    'administered_at': administeredAt?.toIso8601String(),
    'location': location,
    'notes': notes,
    'status': status.name,
  };


  static VaccinationStatus _statusFromString(String? s) {
    switch (s) {
      case 'administered': return VaccinationStatus.administered;
      case 'missed': return VaccinationStatus.missed;
      default: return VaccinationStatus.scheduled;
    }
  }
}