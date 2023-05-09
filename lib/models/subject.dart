import 'package:hive/hive.dart';

part 'subject.g.dart';

@HiveType(typeId: 4)
class Subject {
  @HiveField(0)
  int id;

  @HiveField(1)
  int lecturerId;

  @HiveField(2)
  int courseId;

  @HiveField(3)
  String subjectCode;

  @HiveField(4)
  String subjectName;

  @HiveField(5)
  int yearStudied;

  @HiveField(6)
  int semStudied;

  Subject({
    required this.lecturerId,
    required this.id,
    required this.courseId,
    required this.subjectCode,
    required this.subjectName,
    required this.yearStudied,
    required this.semStudied,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json['id'],
        lecturerId: json['lecturer'],
        courseId: json['course'],
        subjectCode: json['subject_code'],
        subjectName: json['name'],
        yearStudied: json['year_studied'],
        semStudied: json['sem_studied'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'lecturerId': lecturerId,
        'courseId': courseId,
        'subjectCode': subjectCode,
        'subjectName': subjectName,
        'yearStudied': yearStudied,
        'semStudied': semStudied,
      };

  @override
  String toString() {
    return subjectName;
  }
}
