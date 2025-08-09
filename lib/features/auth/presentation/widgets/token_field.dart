import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class TokenField extends StatelessWidget {
  final ValueChanged<String> onCompleted;
  final TextEditingController controller;

  const TokenField({
    super.key, 
    required this.onCompleted, 
    required this.controller
    });

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      controller: controller,
      appContext: context,
      autoFocus: true,
      length: 6,
      hintCharacter: '●',
      enablePinAutofill: true,
      keyboardType: TextInputType.number,
      showCursor: false,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      pinTheme: PinTheme(
        fieldHeight: 44,
        fieldWidth: 44,
        borderWidth: 2,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        shape: PinCodeFieldShape.underline, 
        activeColor: Theme.of(context).colorScheme.primary,
        inactiveColor: Theme.of(context).colorScheme.secondary,
        selectedColor: Theme.of(context).colorScheme.primary,            
      ),
      onCompleted: onCompleted,
    );
  }
}