import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool isObscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const AuthField({
    super.key,
    required this.hintText,
    this.isObscureText = false,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      obscureText: isObscureText,
      textInputAction: TextInputAction.next,
      cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: hintText,
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
      validator: validator,
    );
  }
}
