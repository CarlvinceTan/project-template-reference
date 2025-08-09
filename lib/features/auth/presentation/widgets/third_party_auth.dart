import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ThirdPartyAuth extends StatelessWidget {
  const ThirdPartyAuth({super.key});

  // Individual Auth Button
  Widget _buildAuthButton({
    required BuildContext context,
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      icon: FaIcon(
        icon,
        size: 20,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAuthButton(
          context: context,
          icon: FontAwesomeIcons.google,
          text: 'Google',
          onPressed: () {}, // TODO: Implement Google Auth
        ),
        _buildAuthButton(
          context: context,
          icon: FontAwesomeIcons.apple,
          text: 'Apple',
          onPressed: () {}, // TODO: Implement Apple Auth
        ),
      ],
    );
  }
}