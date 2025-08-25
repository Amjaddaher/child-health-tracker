import 'package:equatable/equatable.dart';

enum ReminderType { appointment, medication, vaccination, custom }
enum ReminderRepeat { none, daily, weekly, monthly }

class Reminder extends Equatable {
  final int id;
  final String childId;
  final String title;
  final String? notes;
  final DateTime dueAt;

  final DateTime createdAt;

  const Reminder({
    required this.id,
    required this.childId,
    required this.title,
    this.notes,
    required this.dueAt,

    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    childId,
    title,
    notes,
    dueAt,

    createdAt,
  ];
}
