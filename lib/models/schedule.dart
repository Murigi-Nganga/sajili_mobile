import 'package:hive/hive.dart';
import 'package:sajili_mobile/models/lecturer.dart';
import 'package:sajili_mobile/models/att_location.dart';
import 'package:sajili_mobile/models/subject.dart';

part 'schedule.g.dart';

@HiveType(typeId: 1)
class Schedule {
  @HiveField(0)
  int id;

  @HiveField(1)
  Subject subject;

  @HiveField(2)
  AttendanceLocation location;

  @HiveField(3)
  Lecturer lecturer;

  @HiveField(4)
  String dayOfWeek;

  @HiveField(5)
  String startTime;

  @HiveField(6)
  String endTime;

  @HiveField(7)
  bool isOnline;

  Schedule({
    required this.id,
    required this.subject,
    required this.location,
    required this.lecturer,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isOnline,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json['id'],
        subject: Subject.fromJson(json['subject']),
        location: AttendanceLocation.fromJson(json['location']),
        lecturer: Lecturer.fromJson(json['lecturer']),
        dayOfWeek: json['day_of_week'],
        startTime: json['start_time'],
        endTime: json['end_time'],
        isOnline: json['is_online'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject': subject.toJson(),
        'lecturer': lecturer.toJson(),
        'location': location.toJson(),
        'dayOfWeek': dayOfWeek,
        'startTime': startTime,
        'endTime': endTime,
        'isOnline': isOnline,
      };

  @override
  String toString() {
    return '$id';
  }
}
