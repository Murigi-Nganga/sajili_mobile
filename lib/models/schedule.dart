import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:sajili_mobile/models/lecturer.dart';
import 'package:sajili_mobile/models/att_location.dart';
import 'package:sajili_mobile/models/subject.dart';

part 'schedule.g.dart';

Time _convertStringToTime(String timeInString) {
  List<String> hourMinList = timeInString.substring(0, 5).split(':');
  return Time(int.parse(hourMinList[0]), int.parse(hourMinList[1]));
}

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
  Time startTime;

  @HiveField(6)
  Time endTime;

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
        startTime: _convertStringToTime(json['start_time']),
        endTime: _convertStringToTime(json['end_time']),
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
