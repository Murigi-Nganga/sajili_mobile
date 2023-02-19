import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/student/controllers/stud_signup_controller.dart';
import 'package:sajili_mobile/utils/form_validators.dart';
import 'package:sajili_mobile/widgets/auth_appbar.dart';
import 'package:sajili_mobile/widgets/custom_form_field.dart';

class StudPasswordSignupScreen extends StatelessWidget {
  StudPasswordSignupScreen({super.key});

  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppbar(title: 'SIgn Up'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 70),
          child: GetBuilder<StudSignupController>(builder: (signupController) {
            return Form(
              key: _signupFormKey,
              child: Column(
                children: [
                  const Text(
                    'Enter your password details',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text('Password must:\n'
                      '- Be between 7 and 15 characters\n'
                      '- Contain special characters such as: !,#,%,&\n'
                      '- Contain a number'),
                  const SizedBox(height: 15),
                  CustomFormField(
                    onChanged: signupController.password,
                    autoFocus: true,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'Password',
                    prefixIconData: Icons.password_rounded,
                    obscureText: true,
                    validator: (value) => validatePassword(value, 'Password'),
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    onChanged: signupController.confirmPassword,
                    keyboardType: TextInputType.visiblePassword,
                    labelText: 'Confirm Password',
                    prefixIconData: Icons.password_rounded,
                    obscureText: true,
                    validator: (value) =>
                        validatePassword(value, 'Confirm Password'),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_signupFormKey.currentState!.validate()) {
                          if (signupController.password !=
                              signupController.confirmPassword) {
                            // Make sure all snackbars are closed
                            Get.closeAllSnackbars();

                            Get.snackbar(
                              'Error',
                              'Passwords don\'t match',
                              icon:
                                  const Icon(Icons.error, color: Colors.white),
                              backgroundColor:
                                  const Color.fromARGB(150, 207, 0, 0),
                              colorText: Colors.white,
                            );
                          } else {
                            Get.toNamed(Routes.studImageSignupRoute);
                          }
                        }
                      },
                      child: const Text(
                        'Continue',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(
                      value: 0.75,
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
      // floatingActionButton: FloatingActionButton(
      //     onPressed: () {},
      //     child: const Icon(Icons.access_alarm, color: Colors.white)),
    );
  }
}
