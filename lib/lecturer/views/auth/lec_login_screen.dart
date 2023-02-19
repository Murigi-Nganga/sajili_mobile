import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/lecturer/controllers/lec_login_controller.dart';
import 'package:sajili_mobile/routes/app_routes.dart';
import 'package:sajili_mobile/utils/form_validators.dart';
import 'package:sajili_mobile/widgets/custom_form_field.dart';

class LecLoginScreen extends StatelessWidget {
  LecLoginScreen({super.key});

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Log In',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(height: 30),
            GetBuilder<LecLoginController>(builder: (loginController) {
              return Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Enter your login details',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomFormField(
                      autoFocus: true,
                      onChanged: loginController.email,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'School email address',
                      prefixIconData: Icons.email_rounded,
                      validator: (value) =>
                          validateLecEmail(value, 'School email address'),
                    ),
                    const SizedBox(height: 10),
                    CustomFormField(
                      onChanged: loginController.password,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: 'Password',
                      prefixIconData: Icons.password_rounded,
                      obscureText: true,
                      validator: (value) => validatePassword(value, 'Password'),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: ElevatedButton(
                        onPressed: () => {
                          if (_loginFormKey.currentState!.validate())
                            {
                              //! Pass the login details here
                            }
                        },
                        child: const Text('Log In'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () => Get.offAllNamed(Routes.lecSignupRoute),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
