import 'package:equatable/equatable.dart';

class Measurement extends Equatable {
  final String id;
  final String childId;
  final DateTime date;
  final double? weight;
  final double? height;
  final double? headCirc;

  const Measurement({
    required this.id,
    required this.childId,
    required this.date,
    this.weight,
    this.height,
    this.headCirc,
  });

  @override
  List<Object?> get props => [id, childId, date, weight, height, headCirc];
}
