import 'package:agora/core/utils/validators.dart';
import 'package:agora/core/utils/widget_modifiers.dart';
import 'package:agora/features/auth/presentation/widgets/auth_field.dart';
import 'package:agora/features/auth/presentation/widgets/return_button.dart';
import 'package:flutter/material.dart';

class RestorePasswordPage extends StatefulWidget {
  const RestorePasswordPage({super.key});

  @override
  State<RestorePasswordPage> createState() => _RestorePasswordPageState();
}

class _RestorePasswordPageState extends State<RestorePasswordPage> {

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1, 
          bottom: 0.0,
          left: MediaQuery.of(context).size.width * 0.1, 
          right: MediaQuery.of(context).size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(),
            Column(
              children: [
                Text(
                  "Reset Password",
                  style: Theme.of(context).textTheme.displayMedium
                ),
                SizedBox(
                  height:10
                ),
                Text(
                  "Your new password has to have a minimum of at least 6 characters",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium
                ),
              ],
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  AuthField(
                    hintText: "Password", 
                    controller: passwordController,
                    isObscureText: true,
                    validator: (value) => validateComplexPassword(value),
                  ),
                  AuthField(
                    hintText: "Confirm Password", 
                    controller: confirmPasswordController,
                    isObscureText: true,
                    validator: (value) => validateConfirmPassword(value, passwordController.text),
                  ),
                  //AuthButton(text: "Reset"),
                ].divide(SizedBox(height: 10)),
              ),
            ),
            ReturnButton(text: "Back"),
          ].divide(const SizedBox(height: 10)),
        ),
      ),
    );
  }
}