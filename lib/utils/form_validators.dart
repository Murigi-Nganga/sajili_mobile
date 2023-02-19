//? Name Validator
final RegExp nameRegExp = RegExp(r'^[A-Za-z\s]+$');

String? validateName(String? value, String fieldName) {
  if (value!.trim().isEmpty) {
    return ("Enter your ${fieldName.toLowerCase()}");
  }
  if (!(nameRegExp.hasMatch(value))) {
    return ("Only alphabet letters are allowed for the \n$fieldName");
  }
  return null;
}

//? Student Email Validator
final RegExp studentEmailRegExp = RegExp(r'@students.uonbi.ac.ke$');

String? validateEmail(String? value, String fieldName) {
  if (value!.trim().isEmpty) {
    return ("Enter your ${fieldName.toLowerCase()}");
  }
  if (!(studentEmailRegExp.hasMatch(value))) {
    return ("Please use your school email address");
  }
  return null;
}

//? Lecturer Email Validator
final RegExp lecEmailRegExp = RegExp(r'@uonbi.ac.ke$');

String? validateLecEmail(String? value, String fieldName) {
  if (value!.trim().isEmpty) {
    return ("Enter your ${fieldName.toLowerCase()}");
  }
  if (!(lecEmailRegExp.hasMatch(value))) {
    return ("Please use your school email address");
  }
  return null;
}

//? Phone Number Validator
final RegExp phoneNumberRegExp = RegExp(r'^(01|07)\d{8}$');

String? validatePhoneNumber(String? value, String fieldName) {
  if (value!.trim().isEmpty) {
    return ("Enter your ${fieldName.toLowerCase()}");
  }
  if (!phoneNumberRegExp.hasMatch(value)) {
    return ("Please enter a valid phone number");
  }
  return null;
}

//? Registration Number validator
final RegExp regNumberRegExp = RegExp(r'^[A-Z].*\d{4}$');

String? validateRegNumber(String? value, String fieldName) {
  if (value!.trim().isEmpty) {
    return ("Enter your ${fieldName.toLowerCase()}");
  }
  if (!regNumberRegExp.hasMatch(value)) {
    return ("Please enter a valid registration number");
  }
  return null;
}

//? ID Number Validator
final RegExp idNumberRegExp = RegExp(r'\d{8}');

String? validateIdNumber(String? value, String fieldName) {
  if (value!.trim().isEmpty) {
    return ("Enter your ${fieldName.toLowerCase()}");
  }
  if (!idNumberRegExp.hasMatch(value)) {
    return ("Please enter a valid id number");
  }
  return null;
}

//? Password validator
final RegExp passwordRegExp =
    RegExp(r'^(?=.*\d{1})(?=(.*\W){1})(?=.*[a-zA-Z])(?!.*\s).{7,15}$');

String? validatePassword(String? value, String fieldName) {
  if (value!.trim().isEmpty) {
    return ("Enter your ${fieldName.toLowerCase()}");
  }
  if (!passwordRegExp.hasMatch(value)) {
    return ('Please enter a valid password');
  }
  return null;
}
