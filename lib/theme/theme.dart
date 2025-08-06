import 'package:flutter/material.dart';
import 'package:agora/theme/app_pallete.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.primaryBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppPallete.darkPrimary,
      secondary: AppPallete.darkSecondary,
      surface: AppPallete.primaryBackground,
      onPrimary: AppPallete.primaryText,
      onSecondary: AppPallete.secondaryText,
      onSurface: AppPallete.primaryText,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppPallete.primaryText),
      bodyMedium: TextStyle(color: AppPallete.primaryText),
      bodySmall: TextStyle(color: AppPallete.primaryText),
    ),
  );

  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.lightPrimaryBackground,
    colorScheme: const ColorScheme.light(
      primary: AppPallete.lightPrimary,
      secondary: AppPallete.lightSecondary,
      surface: AppPallete.lightPrimaryBackground,
      onPrimary: AppPallete.lightPrimaryText,
      onSecondary: AppPallete.lightSecondaryText,
      onSurface: AppPallete.lightPrimaryText,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppPallete.lightPrimaryText),
      bodyMedium: TextStyle(color: AppPallete.lightPrimaryText),
      bodySmall: TextStyle(color: AppPallete.lightPrimaryText),
    ),
  );
}
