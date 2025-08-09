import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  final String text;
  const SectionDivider({super.key, required this.text});

  // Private helper function for creating the SizedBox with Divider
  Widget _dividerWithSizedBox(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 1.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _dividerWithSizedBox(context), 
        Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        _dividerWithSizedBox(context), 
      ],
    );
  }
}