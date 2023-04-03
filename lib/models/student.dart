class Student {
  String regNo;
  String firstName;
  String secondName;
  String phoneNumber;
  String email;
  int yearOfStudy;
  String? imagePath;
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
