import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {
  final String text;
  const ReturnButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.arrow_back,
          color: Theme.of(context).colorScheme.primary,
          size: 14,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}