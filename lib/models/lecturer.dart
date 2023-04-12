class Lecturer {
  int id;
  String firstName;
  String secondName;
  String phoneNumber;
  String email;
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
