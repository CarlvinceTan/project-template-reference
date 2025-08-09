import 'package:agora/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  // Dark Theme Typography
  static final darkTheme = AppTypographyData(
    // Display styles
    displayLarge: GoogleFonts.montserrat(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: AppPallete.primaryText,
    ),
    displayMedium: GoogleFonts.montserrat(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppPallete.primaryText,
    ),
    displaySmall: GoogleFonts.montserrat(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppPallete.primaryText,
    ),
    
    // Headline styles
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppPallete.primaryText,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppPallete.primaryText,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppPallete.primaryText,
    ),
    
    // Title styles
    titleLarge: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppPallete.primaryText,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: AppPallete.primaryText,
    ),
    titleSmall: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppPallete.primaryText,
    ),
    
    // Body styles
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppPallete.primaryText,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppPallete.primaryText,
    ),
    bodySmall: GoogleFonts.montserrat(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppPallete.primaryText,
    ),
    
    // Label styles
    labelLarge: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppPallete.infoTextDark,
    ),
    labelMedium: GoogleFonts.montserrat(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppPallete.hyperlink,
    ),
    labelSmall: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppPallete.error,
    ),
  );

  // Light Theme Typography
  static final lightTheme = AppTypographyData(
    // Display styles
    displayLarge: GoogleFonts.montserrat(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: AppPallete.lightSecondary,
    ),
    displayMedium: GoogleFonts.montserrat(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppPallete.lightSecondary,
    ),
    displaySmall: GoogleFonts.montserrat(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppPallete.lightSecondary,
    ),
    
    // Headline styles
    headlineLarge: GoogleFonts.montserrat(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: AppPallete.lightSecondary,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppPallete.lightSecondary,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppPallete.lightSecondary,
    ),
    
    // Title styles
    titleLarge: GoogleFonts.montserrat(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppPallete.lightSecondary,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: AppPallete.lightSecondary,
    ),
    titleSmall: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppPallete.lightSecondary,
    ),
    
    // Body styles
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: AppPallete.lightSecondary,
    ),
    bodyMedium: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppPallete.lightSecondary,
    ),
    bodySmall: GoogleFonts.montserrat(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppPallete.lightSecondary,
    ),
    
    // Label styles
    labelLarge: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppPallete.lightInfoTextDark,
    ),
    labelMedium: GoogleFonts.montserrat(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: AppPallete.hyperlink,
    ),
    labelSmall: GoogleFonts.montserrat(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppPallete.error,
    ),
  );
}

// Data class to hold typography styles
class AppTypographyData {
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  const AppTypographyData({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  // Convert to Flutter's TextTheme
  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }
}
