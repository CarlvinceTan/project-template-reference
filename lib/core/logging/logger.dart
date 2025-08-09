import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:agora/core/di/init_dependencies.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
  critical,
}

enum LogType {
  general,
  network,
  stateChange,
  navigation,
  auth,
  database,
  ui,
  performance,
}

@singleton
class AppLogger {
  static const String _appName = 'Agora';
  
  // Clean logging for Flutter console (no ANSI colors)

  /// Log a debug message
  void debug(String message, {LogType type = LogType.general, Object? data}) {
    _log(LogLevel.debug, message, type: type, data: data);
  }

  /// Log an info message
  void info(String message, {LogType type = LogType.general, Object? data}) {
    _log(LogLevel.info, message, type: type, data: data);
  }

  /// Log a warning message
  void warning(String message, {LogType type = LogType.general, Object? data}) {
    _log(LogLevel.warning, message, type: type, data: data);
  }

  /// Log an error message
  void error(String message, {LogType type = LogType.general, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, type: type, data: error, stackTrace: stackTrace);
  }

  /// Log a critical error message
  void critical(String message, {LogType type = LogType.general, Object? error, StackTrace? stackTrace}) {
    _log(LogLevel.critical, message, type: type, data: error, stackTrace: stackTrace);
  }

  /// Log state changes (useful for bloc/cubit)
  void stateChange(String from, String to, {String? context, Object? data}) {
    final message = '[$context] $from → $to';
    _log(LogLevel.info, message, type: LogType.stateChange, data: data);
  }

  /// Log navigation events
  void navigation(String route, {String? from, Object? data}) {
    final message = from != null ? '$from → $route' : 'Navigate to $route';
    _log(LogLevel.info, message, type: LogType.navigation, data: data);
  }

  /// Log network requests
  void network(String method, String url, {int? statusCode, Object? data}) {
    final status = statusCode != null ? ' [$statusCode]' : '';
    final message = '$method $url$status';
    final level = _getNetworkLogLevel(statusCode);
    _log(level, message, type: LogType.network, data: data);
  }

  /// Log authentication events
  void auth(String action, {bool success = true, Object? data}) {
    final status = success ? '✓' : '✗';
    final message = '$status Auth: $action';
    final level = success ? LogLevel.info : LogLevel.warning;
    _log(level, message, type: LogType.auth, data: data);
  }

  /// Log database operations
  void database(String operation, String table, {bool success = true, Object? data}) {
    final status = success ? '✓' : '✗';
    final message = '$status DB: $operation on $table';
    final level = success ? LogLevel.info : LogLevel.error;
    _log(level, message, type: LogType.database, data: data);
  }

  /// Log UI events
  void ui(String event, {String? widget, Object? data}) {
    final widgetInfo = widget != null ? ' [$widget]' : '';
    final message = 'UI: $event$widgetInfo';
    _log(LogLevel.debug, message, type: LogType.ui, data: data);
  }

  /// Log performance metrics
  void performance(String operation, Duration duration, {Object? data}) {
    final message = 'Performance: $operation took ${duration.inMilliseconds}ms';
    final level = duration.inMilliseconds > 1000 ? LogLevel.warning : LogLevel.info;
    _log(level, message, type: LogType.performance, data: data);
  }

  void _log(
    LogLevel level,
    String message, {
    LogType type = LogType.general,
    Object? data,
    StackTrace? stackTrace,
  }) {
    // Only log in debug mode or for critical errors
    if (!kDebugMode && level != LogLevel.critical) return;

    final timestamp = DateTime.now().toIso8601String().split('T')[1].split('.')[0];
    
    // Get caller information from stack trace
    final callerInfo = _getCallerInfo();
    
    // Use clean format for Flutter console (no colors)
    final cleanMessage = _formatCleanMessage(level, type, message, timestamp, callerInfo);
    
    // Use developer.log for structured logging (shows in IDE)
    developer.log(
      cleanMessage,
      name: _appName,
      level: _getDeveloperLogLevel(level),
      error: level == LogLevel.error || level == LogLevel.critical ? data : null,
      stackTrace: stackTrace,
    );

    // Also print clean format to console for Flutter debugging
    if (kDebugMode) {
      print(cleanMessage);
      if (data != null) {
        print('   📊 Data: $data');
      }
      if (stackTrace != null) {
        print('   📍 StackTrace: $stackTrace');
      }
    }
  }

  String _formatCleanMessage(LogLevel level, LogType type, String message, String timestamp, String callerInfo) {
    final levelIcon = _getLevelIcon(level);
    final typeIcon = _getTypeIcon(type);
    final levelName = _getLevelName(level);
    final typeName = _getTypeName(type);
    
    return '$levelIcon $typeIcon [$timestamp] $levelName/$typeName ($callerInfo): $message';
  }

  String _getCallerInfo() {
    try {
      final stackTrace = StackTrace.current;
      final frames = stackTrace.toString().split('\n');
      
      // Look for the first frame that's not in the logger files
      for (final frame in frames) {
        if (frame.contains('package:agora/') && 
            !frame.contains('logger.dart') && 
            !frame.contains('logger_utils.dart')) {
          
          // Extract file name and line number
          final match = RegExp(r'package:agora/(.+\.dart):(\d+)').firstMatch(frame);
          if (match != null) {
            final filePath = match.group(1)!;
            final lineNumber = match.group(2)!;
            
            // Get just the file name without the full path
            final fileName = filePath.split('/').last;
            return '$fileName:$lineNumber';
          }
        }
      }
      
      return 'unknown';
    } catch (e) {
      return 'unknown';
    }
  }

  String _getLevelIcon(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🐛';
      case LogLevel.info:
        return 'ℹ️ ';
      case LogLevel.warning:
        return '⚠️ ';
      case LogLevel.error:
        return '❌';
      case LogLevel.critical:
        return '💥';
    }
  }

  String _getTypeIcon(LogType type) {
    switch (type) {
      case LogType.general:
        return '📝';
      case LogType.network:
        return '🌐';
      case LogType.stateChange:
        return '🔄';
      case LogType.navigation:
        return '🧭';
      case LogType.auth:
        return '🔐';
      case LogType.database:
        return '💾';
      case LogType.ui:
        return '🎨';
      case LogType.performance:
        return '⚡';
    }
  }



  LogLevel _getNetworkLogLevel(int? statusCode) {
    if (statusCode == null) return LogLevel.info;
    if (statusCode >= 200 && statusCode < 300) return LogLevel.info;
    if (statusCode >= 400 && statusCode < 500) return LogLevel.warning;
    if (statusCode >= 500) return LogLevel.error;
    return LogLevel.info;
  }

  String _getLevelName(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warning:
        return 'WARN';
      case LogLevel.error:
        return 'ERROR';
      case LogLevel.critical:
        return 'CRITICAL';
    }
  }

  String _getTypeName(LogType type) {
    switch (type) {
      case LogType.general:
        return 'General';
      case LogType.network:
        return 'Network';
      case LogType.stateChange:
        return 'State';
      case LogType.navigation:
        return 'Navigation';
      case LogType.auth:
        return 'Auth';
      case LogType.database:
        return 'Database';
      case LogType.ui:
        return 'UI';
      case LogType.performance:
        return 'Performance';
    }
  }

  int _getDeveloperLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 500;
      case LogLevel.info:
        return 800;
      case LogLevel.warning:
        return 900;
      case LogLevel.error:
        return 1000;
      case LogLevel.critical:
        return 1200;
    }
  }
}

// =============================================================================
// GLOBAL UTILITY FUNCTIONS & EXTENSIONS
// =============================================================================

/// Global logger getter for easy access throughout the app
/// Returns null if logger is not yet registered (during app initialization)
AppLogger? get logger {
  try {
    return getIt<AppLogger>();
  } catch (e) {
    // Logger not yet registered during initialization
    return null;
  }
}

/// Convenient logging functions for quick access
/// These are safe to call during app initialization
void logDebug(String message, {LogType type = LogType.general, Object? data}) {
  logger?.debug(message, type: type, data: data);
}

void logInfo(String message, {LogType type = LogType.general, Object? data}) {
  logger?.info(message, type: type, data: data);
}

void logWarning(String message, {LogType type = LogType.general, Object? data}) {
  logger?.warning(message, type: type, data: data);
}

void logError(String message, {LogType type = LogType.general, Object? error, StackTrace? stackTrace}) {
  logger?.error(message, type: type, error: error, stackTrace: stackTrace);
}

void logCritical(String message, {LogType type = LogType.general, Object? error, StackTrace? stackTrace}) {
  logger?.critical(message, type: type, error: error, stackTrace: stackTrace);
}

void logStateChange(String from, String to, {String? context, Object? data}) {
  logger?.stateChange(from, to, context: context, data: data);
}

void logNavigation(String route, {String? from, Object? data}) {
  logger?.navigation(route, from: from, data: data);
}

void logNetwork(String method, String url, {int? statusCode, Object? data}) {
  logger?.network(method, url, statusCode: statusCode, data: data);
}

void logAuth(String action, {bool success = true, Object? data}) {
  logger?.auth(action, success: success, data: data);
}

void logDatabase(String operation, String table, {bool success = true, Object? data}) {
  logger?.database(operation, table, success: success, data: data);
}

void logUI(String event, {String? widget, Object? data}) {
  logger?.ui(event, widget: widget, data: data);
}

void logPerformance(String operation, Duration duration, {Object? data}) {
  logger?.performance(operation, duration, data: data);
}

/// Extension methods for easy logging from any object
/// These are safe to call during app initialization
extension ObjectLoggerExtensions on Object {
  void logDebug(String message, {LogType type = LogType.general}) {
    logger?.debug('[$runtimeType] $message', type: type);
  }
  
  void logInfo(String message, {LogType type = LogType.general}) {
    logger?.info('[$runtimeType] $message', type: type);
  }
  
  void logWarning(String message, {LogType type = LogType.general}) {
    logger?.warning('[$runtimeType] $message', type: type);
  }
  
  void logError(String message, {Object? error, StackTrace? stackTrace, LogType type = LogType.general}) {
    logger?.error('[$runtimeType] $message', error: error, stackTrace: stackTrace, type: type);
  }
}


