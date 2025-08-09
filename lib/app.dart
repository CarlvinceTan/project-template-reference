import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora/core/app_router.dart';
import 'package:agora/core/theme/app_theme.dart';
import 'package:agora/core/theme/bloc/theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp.router(
          title: 'Agora',
          routerConfig: router,
          debugShowCheckedModeBanner: false,

          // Theme
          theme: AppTheme.lightTheme, 
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.themeMode, 
        );
      },
    );
  }
}