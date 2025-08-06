import 'package:agora/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTypography {
  static final title = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: AppPallete.primaryText,
  );

  static final heading1 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppPallete.primaryText,
  );

  static final heading2 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppPallete.primaryText,
  );

  static final heading3 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppPallete.primaryText,
  );

  static final bodyLarge = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppPallete.primaryText,
  );

  static final bodyMedium = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppPallete.primaryText,
  );

  static final bodySmall = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppPallete.primaryText,
  );

  static final infoTextDark = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppPallete.infoTextDark,
  );

  static final infoTextLight = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppPallete.infoTextLight,
  );

  static final errorText = TextStyle(
    fontFamily: 'SF Mono',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppPallete.error,
  );

  static final hyperlinkText = TextStyle(
    fontFamily: 'SF Pro Text',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppPallete.hyperlink,
  );
}
