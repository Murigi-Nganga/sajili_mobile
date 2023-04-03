//? Student Email Validator
final RegExp studEmailRegExp = RegExp(r'@students.uonbi.ac.ke$');

String? validateStudEmail(String? value, String fieldName) {
  if (value!.trim().isEmpty) {
    return ("Enter your ${fieldName.toLowerCase()}");
  }
  if (!(studEmailRegExp.hasMatch(value))) {
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
