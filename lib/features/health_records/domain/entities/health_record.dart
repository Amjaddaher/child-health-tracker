import 'package:equatable/equatable.dart';


// "created_at":"2025-08-22 11:42:03.98047+00",
// "child_id":"6281ef8d-eaa8-4ff9-ae0f-5389a88c1634",
// "date":"2025-08-22 14:41:54",
// "details":"test\n"
// }
class HealthRecord extends Equatable {
  final String id;
  final String childId;
  final DateTime date;
  final DateTime createdAt;
  final String? details; // يمكن يكون null إذا ما في ملف

  const HealthRecord({
    required this.id,
    required this.childId,
    required this.date,
    required this.details,

    required this.createdAt,
  });

  @override
  List<Object?> get props =>
      [id, childId, date, createdAt, details,];
}
