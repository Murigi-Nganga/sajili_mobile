import 'package:hive/hive.dart';

part 'lecturer.g.dart';

@HiveType(typeId: 2)
class Lecturer {
  @HiveField(0)
  int id;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String secondName;

  @HiveField(3)
  String phoneNumber;

  @HiveField(4)
  String email;

  @HiveField(5)
  String? token;

  Lecturer({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.phoneNumber,
    required this.email,
    this.token,
  });

  factory Lecturer.fromJson(Map<String, dynamic> json) => Lecturer(
        id: json['id'],
        firstName: json['first_name'],
        secondName: json['second_name'],
        phoneNumber: json['phone_number'],
        email: json['email'],
        token: json['token'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'secondName': secondName,
        'email': email,
        'phoneNumber': phoneNumber,
        'token': token,
      };

  @override
  String toString() {
    return email;
  }
}
