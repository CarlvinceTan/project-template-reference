import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agora/core/logging/logger.dart';


/// BlocObserver that automatically logs all Bloc events and state changes
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(BlocBase bloc, Object? event) {
    // Only call super for Bloc instances, not Cubit
    if (bloc is Bloc) {
      super.onEvent(bloc, event);
    }
    
    final blocName = bloc.runtimeType.toString();
    final eventName = event.runtimeType.toString();
    
    logInfo(
      'Event dispatched: $eventName',
      type: LogType.stateChange,
      data: {
        'bloc': blocName,
        'event': eventName,
        'eventData': event.toString(),
      },
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    
    final blocName = bloc.runtimeType.toString();
    final currentState = change.currentState.runtimeType.toString();
    final nextState = change.nextState.runtimeType.toString();
    
    logStateChange(
      currentState,
      nextState,
      context: blocName,
      data: {
        'bloc': blocName,
        'currentState': change.currentState.toString(),
        'nextState': change.nextState.toString(),
      },
    );
  }

  @override
  void onTransition(BlocBase bloc, Transition transition) {
    // Only call super for Bloc instances, not Cubit
    if (bloc is Bloc) {
      super.onTransition(bloc, transition);
    }
    
    final blocName = bloc.runtimeType.toString();
    final eventName = transition.event.runtimeType.toString();
    final currentState = transition.currentState.runtimeType.toString();
    final nextState = transition.nextState.runtimeType.toString();
    
    logInfo(
      'Transition: $currentState → $nextState',
      type: LogType.stateChange,
      data: {
        'bloc': blocName,
        'event': eventName,
        'transition': '$currentState → $nextState',
        'eventData': transition.event.toString(),
        'currentStateData': transition.currentState.toString(),
        'nextStateData': transition.nextState.toString(),
      },
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    
    final blocName = bloc.runtimeType.toString();
    
    logError(
      'Bloc error in $blocName',
      type: LogType.stateChange,
      error: error,
    );
    
    // Also log the stack trace for debugging
    logError(
      'Stack trace for $blocName error',
      type: LogType.stateChange,
      error: stackTrace.toString(),
    );
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    
    final blocName = bloc.runtimeType.toString();
    
    logInfo(
      'Bloc created: $blocName',
      type: LogType.stateChange,
      data: {
        'bloc': blocName,
        'initialState': bloc.state.runtimeType.toString(),
        'initialStateData': bloc.state.toString(),
      },
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    
    final blocName = bloc.runtimeType.toString();
    
    logInfo(
      'Bloc closed: $blocName',
      type: LogType.stateChange,
      data: {
        'bloc': blocName,
        'finalState': bloc.state.runtimeType.toString(),
        'finalStateData': bloc.state.toString(),
      },
    );
  }
}
