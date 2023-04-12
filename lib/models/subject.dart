class Subject {
  int id;
  int lecturerId;
  int courseId;
  String subjectCode;
  String subjectName;
  int yearStudied;
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
