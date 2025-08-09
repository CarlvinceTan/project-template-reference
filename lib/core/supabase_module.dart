import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:agora/core/constants.dart';
import 'package:agora/core/logging/logger.dart';


@module
abstract class SupabaseModule {
  @preResolve
  @singleton
  Future<SupabaseClient> get supabaseClient async {
    // Log configuration status
    logInfo('Checking Supabase configuration...', type: LogType.database);
    
    // Validate configuration before initializing
    if (!Constants.isSupabaseConfigured) {
      final errorMessage = '''
🚨 SUPABASE CONFIGURATION ERROR 🚨

${Constants.configurationStatus}

To fix this:
1. Go to https://supabase.com/dashboard
2. Create a new project or select existing one
3. Go to Settings > API
4. Copy your Project URL and anon public key
5. Replace the values in lib/core/constants.dart

OR set environment variables:
- SUPABASE_URL=your-project-url
- SUPABASE_ANON_KEY=your-anon-key
      ''';
      
      logCritical('Supabase configuration invalid', 
        type: LogType.database, 
        error: errorMessage
      );
      
      throw Exception(errorMessage);
    }

    logInfo('Initializing Supabase...', type: LogType.database);
    
    await Supabase.initialize(
      url: Constants.supabaseUrl,
      anonKey: Constants.supabaseAnnonKey,
    );
    
    logInfo('Supabase initialized successfully', 
      type: LogType.database, 
      data: {'url': Constants.supabaseUrl}
    );
    
    return Supabase.instance.client;
  }
}
