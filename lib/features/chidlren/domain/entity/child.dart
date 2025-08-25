import 'package:equatable/equatable.dart';

class Child extends Equatable {
  final String? id;
  final String name;
  final DateTime? birthDate;
  final double? weight;
  final double? height;
  final double? headCircumference;
  final String? notes;
  final String? doctorId;

  const Child({
    required this.id,
    required this.name,
    this.birthDate,
    required this.weight,
    required this.height,
    required this.headCircumference,
    required  this.notes,
   required this.doctorId,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    birthDate,
    weight,
    height,
    headCircumference,
    notes,
    doctorId,
  ];
}
