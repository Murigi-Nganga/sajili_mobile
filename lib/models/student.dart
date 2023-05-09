import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  String regNo;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String secondName;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  String email;

  @HiveField(5)
  int yearOfStudy;

  @HiveField(6)
  String? imagePath;

  @HiveField(7)
  String token;

  Student({
    required this.regNo,
    required this.firstName,
    required this.secondName,
    required this.phoneNumber,
    required this.email,
    required this.yearOfStudy,
    required this.imagePath,
    required this.token,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        regNo: json['reg_no'],
        firstName: json['first_name'],
        secondName: json['second_name'],
        phoneNumber: json['phone_number'],
        email: json['email'],
        yearOfStudy: json['year_of_study'],
        imagePath: json['image_path'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'regNo': regNo,
        'firstName': firstName,
        'secondName': secondName,
        'phoneNumber': phoneNumber,
        'email': email,
        'yearOfStudy': yearOfStudy,
        'imagePath': imagePath,
        'token': token,
      };

  @override
  String toString() {
    return regNo;
  }
}
