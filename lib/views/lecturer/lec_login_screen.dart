import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sajili_mobile/controllers/lec_login_controller.dart';
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
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Theme.of(context).colorScheme.secondary,
              ),
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 30),
                    CustomFormField(
                      onChanged: loginController.email,
                      keyboardType: TextInputType.emailAddress,
                      labelText: 'School email address',
                      prefixIconData: Icons.email_rounded,
                      validator: (value) =>
                          validateLecEmail(value, 'School email address'),
                    ),
                    const SizedBox(height: 15),
                    CustomFormField(
                      textInputAction: TextInputAction.done,
                      onChanged: loginController.password,
                      keyboardType: TextInputType.visiblePassword,
                      labelText: 'Password',
                      prefixIconData: Icons.password_rounded,
                      obscureText: true,
                      validator: (value) => validatePassword(value, 'Password'),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .7,
                      child: loginController.status.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () => {
                                // close keyboard if open
                                SystemChannels.textInput
                                    .invokeMethod('TextInput.hide'),

                                if (_loginFormKey.currentState!.validate())
                                  {
                                    loginController.login().whenComplete(() {
                                      if (loginController.status.isSuccess) {
                                        Get.offAndToNamed(Routes.lecHomeRoute);
                                      }
                                    })
                                  }
                              },
                              child: const Text('Log In'),
                            ),
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
