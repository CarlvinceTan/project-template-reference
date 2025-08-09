import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/app_icon.png',
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.width * 0.25,
      color: Theme.of(context).colorScheme.secondary,
      colorBlendMode: BlendMode.srcIn,
      errorBuilder: (context, error, stackTrace) {
        // Fallback icon if asset fails to load
        return Icon(
          Icons.apps,
          color: Theme.of(context).colorScheme.secondary,
          size: MediaQuery.of(context).size.width * 0.25,
        );
      },
    );
  }
}
