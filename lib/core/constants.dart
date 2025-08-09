import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment variables and shared app constants.
abstract class Constants {
  /// Supabase project URL
  /// Set this in your .env file as: SUPABASE_URL=https://your-project-id.supabase.co
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? _defaultSupabaseUrl;

  /// Supabase anonymous key
  /// Set this in your .env file as: SUPABASE_ANON_KEY=your-anon-key-here
  static String get supabaseAnnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? _defaultSupabaseAnonKey;

  // Default values (fallback when .env is not configured)
  // TODO: Replace these with your actual Supabase project credentials
  // You can find these in your Supabase project dashboard:
  // 1. Go to https://supabase.com/dashboard
  // 2. Select your project
  // 3. Go to Settings > API
  // 4. Copy the "Project URL" and "anon public" key
  
  static const String _defaultSupabaseUrl = 'https://your-project-id.supabase.co';
  static const String _defaultSupabaseAnonKey = 'your-anon-key-here';

  /// Validates that Supabase configuration is properly set up
  static bool get isSupabaseConfigured {
    return supabaseUrl.isNotEmpty && 
           supabaseUrl != _defaultSupabaseUrl &&
           supabaseAnnonKey.isNotEmpty && 
           supabaseAnnonKey != _defaultSupabaseAnonKey;
  }

  /// Returns configuration status for debugging
  static String get configurationStatus {
    if (isSupabaseConfigured) {
      return 'Supabase configuration: ✅ Valid';
    } else {
      return 'Supabase configuration: ❌ Missing or invalid\n'
             'URL: ${supabaseUrl.isEmpty ? "Empty" : supabaseUrl}\n'
             'Key: ${supabaseAnnonKey.isEmpty ? "Empty" : "Set but may be default"}';
    }
  }
}