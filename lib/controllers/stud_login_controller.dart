import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sajili_mobile/local_storage/local_storage.dart';
import 'package:sajili_mobile/utils/api_endpoints.dart';
import 'package:sajili_mobile/models/student.dart';
import 'package:sajili_mobile/utils/custom_snack.dart';
import 'package:sajili_mobile/utils/enums.dart';

// Manages the state of the login form
class StudLoginController extends GetxController with StateMixin<Student> {
  Rx<String> email = Rx('');
  Rx<String> password = Rx('');

  @override
  onInit() {
    super.onInit();
    change(null, status: RxStatus.empty()); // set initial state
  }

  Future<void> login() async {
    change(null, status: RxStatus.loading());
    final requestBody = {'email': email.value, 'password': password.value};

    try {
      await http
          .post(Uri.parse(Endpoints.studLoginUrl), body: requestBody)
          .then((response) {
        final responseBody = json.decode(response.body);

        if (response.statusCode == 200) {
          change(Student.fromJson(responseBody), status: RxStatus.success());
          LocalStorage().persistUser(state, UserType.student);
          showSnack(
            'Success',
            'Login Successful',
            Colors.green[400]!,
            Icons.grade_rounded,
            0,
          );
        } else if (response.statusCode == 404) {
          change(null, status: RxStatus.error());
          showSnack(
            'Error',
            'Wrong login credentials',
            Colors.red[400]!,
            Icons.error_rounded,
            1,
          );
        }
      });
    } catch (error) {
      change(null, status: RxStatus.error());
      print(error);
      showSnack(
        'Error',
        'Check your internet connection',
        Colors.red[400]!,
        Icons.error_rounded,
        1,
      );
    }
  }
}
