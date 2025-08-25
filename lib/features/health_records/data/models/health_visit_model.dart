import '../../domain/entities/health_record.dart';

class HealthRecordModel extends HealthRecord {
  const HealthRecordModel({
    required super.id,
    required super.childId,
    required super.date,
    required super.details,
    required super.createdAt,


  });

  factory HealthRecordModel.fromMap(Map<String, dynamic> map) {
    return HealthRecordModel(
      id: map['id'] as String,
      childId: map['child_id'] as String,
      date: DateTime.parse(map['date']),
      details: map['details'] as String,
      createdAt: DateTime.parse(map['created_at']),

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'child_id': childId,
      'date': date.toIso8601String(),
      'details': details,
      'created_at': createdAt.toIso8601String(),

    };
  }
}
