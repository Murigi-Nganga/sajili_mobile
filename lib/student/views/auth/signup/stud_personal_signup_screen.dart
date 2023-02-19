import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/student/controllers/stud_signup_controller.dart';
import 'package:sajili_mobile/utils/form_validators.dart';
import 'package:sajili_mobile/widgets/auth_appbar.dart';
import 'package:sajili_mobile/widgets/custom_form_field.dart';

class StudPersonalSignupScreen extends StatelessWidget {
  StudPersonalSignupScreen({super.key});

  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppbar(
        title: 'Sign Up',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 70),
          child: GetBuilder<StudSignupController>(builder: (signupController) {
            return Form(
              key: _signupFormKey,
              child: Column(
                children: [
                  const Text(
                    'Enter your personal details',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomFormField(
                    onChanged: signupController.firstName,
                    autoFocus: true,
                    keyboardType: TextInputType.name,
                    labelText: 'First Name',
                    prefixIconData: Icons.abc_rounded,
                    capitalizeText: true,
                    validator: (value) => validateName(value, 'First Name'),
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    onChanged: signupController.secondName,
                    keyboardType: TextInputType.name,
                    labelText: 'Second Name',
                    prefixIconData: Icons.abc_rounded,
                    capitalizeText: true,
                    validator: (value) => validateName(value, 'Second Name'),
                  ),
                  const SizedBox(height: 10),
                  CustomFormField(
                    onChanged: signupController.phoneNumber,
                    keyboardType: TextInputType.phone,
                    labelText: 'Phone Number',
                    prefixIconData: Icons.phone_rounded,
                    validator: (value) =>
                        validatePhoneNumber(value, 'Phone Number'),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: ElevatedButton(
                      onPressed: () => {
                        if (_signupFormKey.currentState!.validate())
                          {Get.toNamed(Routes.studSchoolSignupRoute)}
                      },
                      child: const Text(
                        'Continue',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => Get.offAllNamed(Routes.studLoginRoute),
                    child: const Text('Log In'),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(
                      value: 0.25,
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
