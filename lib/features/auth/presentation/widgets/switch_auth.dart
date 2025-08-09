import 'package:flutter/material.dart';

class SwitchAuth extends StatelessWidget {
  final String promptText;
  final String linkText;
  final VoidCallback onTap;

  const SwitchAuth({super.key, required this.promptText, required this.linkText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }
}