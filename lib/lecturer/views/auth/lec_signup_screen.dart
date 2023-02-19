import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/lecturer/controllers/lec_signup_controller.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/utils/form_validators.dart';
import 'package:sajili_mobile/widgets/auth_appbar.dart';
import 'package:sajili_mobile/widgets/custom_form_field.dart';

class LecSignupScreen extends StatelessWidget {
  LecSignupScreen({super.key});

  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppbar(title: 'Sign Up'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 70),
          child: GetBuilder<LecSignupController>(builder: (signupController) {
            return Form(
              key: _signupFormKey,
              child: Column(
                children: [
                  const Text(
                    'Enter your details',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomFormField(
                    onChanged: signupController.idNumber,
                    autoFocus: true,
                    keyboardType: TextInputType.text,
                    labelText: 'ID Number',
                    prefixIconData: Icons.app_registration_rounded,
                    validator: (value) => validateIdNumber(value, 'ID Number'),
                  ),
                  const SizedBox(height: 10),
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
                    onChanged: signupController.email,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'School email address',
                    prefixIconData: Icons.email_rounded,
                    validator: (value) =>
                        validateLecEmail(value, 'School email address'),
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
                      onPressed: () => {
                        if (_signupFormKey.currentState!.validate())
                          {Get.offAllNamed(Routes.lecLoginRoute)}
                      },
                      child: const Text(
                        'Sign Up',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => Get.offAllNamed(Routes.lecLoginRoute),
                    child: const Text('Log In'),
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
