import 'package:hive/hive.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/models/student.dart';

part 'attendance.g.dart';

@HiveType(typeId: 5)
class Attendance {
  @HiveField(0)
  int id;

  @HiveField(1)
  Schedule schedule;

  @HiveField(2)
  Student student;

  @HiveField(4)
  DateTime timeSignedIn;

  Attendance({
    required this.id,
    required this.schedule,
    required this.student,
    required this.timeSignedIn,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
        id: json['id'],
        schedule: Schedule.fromJson(json['schedule']),
        student: Student.fromJson(json['student']),
        timeSignedIn: DateTime.parse(json['time_signed_in']));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'schedule': schedule.toJson(),
        'student': student.toJson(),
        'timeSignedIn': timeSignedIn
      };

  @override
  String toString() {
    return id.toString();
  }
}
