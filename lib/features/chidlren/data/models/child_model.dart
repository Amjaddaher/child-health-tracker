
import '../../domain/entity/child.dart';

class ChildModel extends Child {
  const ChildModel({
    required super.id,
    required super.name,
    super.birthDate,
    super.weight,
    super.height,
    super.headCircumference,
    super.notes,
    super.doctorId,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['id'],
      name: json['name'],
      birthDate: json['birth_date'] != null ? DateTime.parse(json['birth_date']) : null,
      weight: (json['weight'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      headCircumference: (json['head_circumference'] as num?)?.toDouble(),
      notes: json['notes'],
      doctorId: json['doctor_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'birth_date': birthDate?.toIso8601String(),
      'weight': weight,
      'height': height,
      'head_circumference': headCircumference,
      'notes': notes,
      'doctor_id': doctorId,
    };
  }
}
