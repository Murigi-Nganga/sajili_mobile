import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/student/controllers/stud_signup_controller.dart';
import 'package:sajili_mobile/utils/form_validators.dart';
import 'package:sajili_mobile/widgets/auth_appbar.dart';
import 'package:sajili_mobile/widgets/custom_form_field.dart';

class StudSchoolSignupScreen extends StatelessWidget {
  StudSchoolSignupScreen({super.key});

  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppbar(title: 'Sign Up'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 70),
          child: GetBuilder<StudSignupController>(builder: (signupController) {
            return Form(
              key: _signupFormKey,
              child: Column(
                children: [
                  const Text(
                    'Enter your student details',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomFormField(
                    onChanged: signupController.regNo,
                    autoFocus: true,
                    keyboardType: TextInputType.text,
                    labelText: 'Registration Number',
                    prefixIconData: Icons.app_registration_rounded,
                    capitalizeText: true,
                    validator: (value) =>
                        validateRegNumber(value, 'Registration Number'),
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    onChanged: signupController.email,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'School email address',
                    prefixIconData: Icons.email_rounded,
                    validator: (value) =>
                        validateEmail(value, 'School email address'),
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    onChanged: signupController.courseName,
                    keyboardType: TextInputType.text,
                    labelText: 'Course Name',
                    prefixIconData: Icons.read_more_rounded,
                    validator: (value) => validateName(value, 'Course Name'),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<int>(
                    value: 1,
                    decoration: const InputDecoration(
                      labelText: 'Year of study',
                      prefixIcon: Icon(Icons.numbers_rounded),
                    ),
                    items: List.generate(4, (index) {
                      return DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text('${index + 1}'),
                      );
                    }),
                    onChanged: (value) {
                      signupController.yearOfStudy(value!.toInt());
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: ElevatedButton(
                      onPressed: () => {
                        if (_signupFormKey.currentState!.validate())
                          {Get.toNamed(Routes.studPasswordSignupRoute)}
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(
                      value: 0.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.secondary),
                      backgroundColor: Colors.black26,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
