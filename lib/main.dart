import 'package:agora/app.dart';
import 'package:agora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:agora/core/theme/bloc/theme_cubit.dart';
import 'package:agora/core/di/init_dependencies.dart';
import 'package:agora/core/logging/app_bloc_observer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  try {
    await dotenv.load(fileName: ".env");
    // Note: Logger not available yet, using print for initialization
    if (kDebugMode) {
      print('✅ Environment variables loaded successfully');
      print('SUPABASE_URL: ${dotenv.env['SUPABASE_URL']}');
    }
  } catch (e) {
    if (kDebugMode) {
      print('⚠️ Could not load .env file: $e');
      print('Using default/fallback configuration...');
    }
  }
  
  await configureDependencies();
  
  // Set up BlocObserver for automatic logging
  Bloc.observer = AppBlocObserver();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<ThemeCubit>(),
        ),
      ],
      child: const MyApp(),
    )
  );
}

