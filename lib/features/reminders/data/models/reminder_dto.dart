import '../../domain/entities/reminder.dart';

ReminderType _typeFromString(String s) => ReminderType.values.firstWhere(
  (e) => e.name == s,
  orElse: () => ReminderType.custom,
);

String _typeToString(ReminderType t) => t.name;

ReminderRepeat _repeatFromString(String s) => ReminderRepeat.values.firstWhere(
  (e) => e.name == s,
  orElse: () => ReminderRepeat.none,
);

String _repeatToString(ReminderRepeat r) => r.name;

class ReminderDto {
  final int id;
  final String childId;
  final String title;
  final String? notes;
  final DateTime dueAt;

  final DateTime createdAt;

  ReminderDto({
    required this.id,
    required this.childId,
    required this.title,
    this.notes,
    required this.dueAt,

    required this.createdAt,
  });

  factory ReminderDto.fromMap(Map<String, dynamic> map) {
    return ReminderDto(
      id: map['id'],
      childId: map['child_id'] as String,
      title: map['title'] as String,
      notes: map['notes'] as String?,
      dueAt: map['due_at'] != null
          ? DateTime.parse(map['due_at'] as String)
          : DateTime.now(),

      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    // 'id': id,
    'child_id': childId,
    'title': title,
    'notes': notes,
    'due_at': dueAt.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
  };

  Reminder toEntity() => Reminder(
    id: id,
    childId: childId,
    title: title,
    notes: notes,
    dueAt: dueAt,

    createdAt: createdAt,
  );

  static ReminderDto fromEntity(Reminder r) => ReminderDto(
    id: r.id,
    childId: r.childId,
    title: r.title,
    notes: r.notes,
    dueAt: r.dueAt,

    createdAt: r.createdAt,
  );
}
