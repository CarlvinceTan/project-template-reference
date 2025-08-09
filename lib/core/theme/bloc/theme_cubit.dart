import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'theme_state.dart';

@singleton
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeSystem()) {
    updateTheme(ThemeMode.system);
  }

  void updateTheme(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        emit(const ThemeLight());
        break;
      case ThemeMode.dark:
        emit(const ThemeDark());
        break;
      case ThemeMode.system:
        emit(const ThemeSystem());
        break;
    }
  }
}