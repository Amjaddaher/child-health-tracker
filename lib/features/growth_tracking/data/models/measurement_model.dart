import '../../domain/entities/measurement.dart';

class MeasurementModel extends Measurement {
  const MeasurementModel({
    required super.id,
    required super.childId,
    required super.date,
    super.weight,
    super.height,
    super.headCirc,
  });

  factory MeasurementModel.fromMap(Map<String, dynamic> map) {
    return MeasurementModel(
      id: map['id'] as String,
      childId: map['child_id'] as String,
      date: DateTime.parse(map['date'] as String),
      weight: (map['weight'] as num?)?.toDouble(),
      height: (map['height'] as num?)?.toDouble(),
      headCirc: (map['head_circ'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    // 'id': id,
    'child_id': childId,
    'date': date.toIso8601String(),
    'weight': weight,
    'height': height,
    'head_circ': headCirc,
  };
}
