part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});
}

class ThemeLight extends ThemeState {
  const ThemeLight() : super(themeMode: ThemeMode.light);
}

class ThemeDark extends ThemeState {
  const ThemeDark() : super(themeMode: ThemeMode.dark);
}

class ThemeSystem extends ThemeState {
  const ThemeSystem() : super(themeMode: ThemeMode.system);
}