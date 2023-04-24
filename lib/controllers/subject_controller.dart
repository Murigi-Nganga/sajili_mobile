import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sajili_mobile/utils/api_endpoints.dart';
import 'package:sajili_mobile/models/subject.dart';
import 'package:sajili_mobile/utils/custom_snack.dart';

class SubjectController extends GetxController with StateMixin<List<Subject>> {
  @override
  onInit() async {
    super.onInit();
    getSubjects();
  }

  Future<void> getSubjects() async {
    change(null, status: RxStatus.loading());

    try {
      await http.get(Uri.parse(Endpoints.getSubjectsByLecId)).then((response) {
        final responseBody = json.decode(response.body);
        if (response.statusCode == 200) {
          final List<Subject> subjects = responseBody
              .map<Subject>((obj) => Subject.fromJson(obj))
              .toList();
          if (subjects.isEmpty) {
            change(subjects, status: RxStatus.empty());
            return;
          }
          change(subjects, status: RxStatus.success());
        } else {
          change(null, status: RxStatus.error('Something went wrong'));
        }
      });
    } catch (error) {
      change(null, status: RxStatus.error(error.toString()));
      showSnack(
        'Error',
        'Please check your network connection',
        Colors.red[400]!,
        Icons.error_rounded,
        1,
      );
    }
  }
}
