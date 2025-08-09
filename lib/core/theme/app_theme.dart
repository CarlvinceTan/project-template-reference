import 'package:flutter/material.dart';
import 'package:agora/core/theme/app_pallete.dart';
import 'package:agora/core/theme/app_typography.dart';

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
    textTheme: AppTypography.darkTheme.toTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(24, 10, 24, 16),
      hintStyle: AppTypography.darkTheme.bodyMedium,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppPallete.darkSecondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppPallete.darkPrimary, width: 2),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppPallete.cursorLight,
      selectionColor: AppPallete.darkSecondary,
      selectionHandleColor: AppPallete.darkPrimary,
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
    textTheme: AppTypography.lightTheme.toTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      contentPadding: EdgeInsets.fromLTRB(24, 10, 24, 16),
      hintStyle: AppTypography.lightTheme.bodyMedium,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppPallete.lightSecondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: AppPallete.lightTertiary, width: 2),
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppPallete.cursorDark,
      selectionColor: AppPallete.lightSecondary,
      selectionHandleColor: AppPallete.lightPrimary,
    ),
  );
}
