import 'package:hive_flutter/hive_flutter.dart';

part 'enums.g.dart';

@HiveType(typeId: 100)
enum UserType {
  @HiveField(0)
  student,

  @HiveField(1)
  lecturer
}

enum AttendanceType {
  none,
  partial,
  full,
}
