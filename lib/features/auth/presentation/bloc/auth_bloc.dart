import 'package:agora/features/auth/domain/use_cases/login_with_email_and_password.dart';
import 'package:agora/features/auth/domain/use_cases/signup_with_email_and_password.dart';
import 'package:agora/features/auth/domain/use_cases/restore_password.dart';
import 'package:agora/features/auth/domain/use_cases/verify_email.dart';
import 'package:agora/features/auth/domain/use_cases/resend_verification_email.dart';
import 'package:agora/features/auth/domain/use_cases/logout.dart';
import 'package:agora/features/auth/domain/entities/user.dart';
import 'package:agora/core/logging/logger.dart';

import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignupWithEmailAndPassword _userSignUp;
  final LoginWithEmailAndPassword _userLogin;
  final RestorePassword _restorePassword;
  final VerifyEmail _verifyEmail;
  final ResendVerificationEmail _resendVerificationEmail;
  final Logout _logout;

  AuthBloc({
    required SignupWithEmailAndPassword userSignUp, 
    required LoginWithEmailAndPassword userLogin,
    required RestorePassword restorePassword,
    required VerifyEmail verifyEmail,
    required ResendVerificationEmail resendVerificationEmail,
    required Logout logout,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _restorePassword = restorePassword,
        _verifyEmail = verifyEmail,
        _resendVerificationEmail = resendVerificationEmail,
        _logout = logout,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthRestorePassword>(_onAuthRestorePassword);
    on<AuthVerifyEmail>(_onAuthVerifyEmail);
    on<AuthResendVerification>(_onAuthResendVerification);
    on<AuthLogout>(_onAuthLogout);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    logStateChange('AuthInitial', 'AuthLoading', context: 'AuthBloc');
    logAuth('Sign up attempt', data: {'email': event.email});
    
    emit(AuthLoading());
    final res = await _userSignUp(
      email: event.email,
      password: event.password,
    ).run();

    res.fold(
      (failure) {
        logAuth('Sign up failed', success: false, data: {'error': failure.message});
        logStateChange('AuthLoading', 'AuthFailure', context: 'AuthBloc');
        emit(AuthFailure(failure.message));
      },
      (user) {
        logAuth('Sign up successful - verification required', success: true, data: {'userId': user.id, 'email': event.email});
        logStateChange('AuthLoading', 'AuthEmailVerificationRequired', context: 'AuthBloc');
        emit(AuthEmailVerificationRequired(event.email));
      },
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    logStateChange('AuthInitial', 'AuthLoading', context: 'AuthBloc');
    logAuth('Login attempt', data: {'email': event.email});
    
    emit(AuthLoading());
    final res = await _userLogin(
      email: event.email,
      password: event.password,
    ).run();

    res.fold(
      (failure) {
        logAuth('Login failed', success: false, data: {'error': failure.message});
        logStateChange('AuthLoading', 'AuthFailure', context: 'AuthBloc');
        emit(AuthFailure(failure.message));
      },
      (user) {
        logAuth('Login successful', success: true, data: {'userId': user.id});
        logStateChange('AuthLoading', 'AuthSuccess', context: 'AuthBloc');
        emit(AuthSuccess(user));
      },
    );
  }

  void _onAuthRestorePassword(AuthRestorePassword event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _restorePassword(
      email: event.email,
    ).run();

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthVerifyEmail(AuthVerifyEmail event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _verifyEmail(
      email: event.email,
      verificationCode: event.verificationCode,
    ).run();

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthResendVerification(AuthResendVerification event, Emitter<AuthState> emit) async {
    logInfo('Resending verification email', type: LogType.auth, data: {'email': event.email});
    emit(AuthLoading());
    
    final res = await _resendVerificationEmail(email: event.email).run();

    res.fold(
      (failure) {
        logAuth('Resend verification failed', success: false, data: {'error': failure.message});
        emit(AuthFailure(failure.message));
      },
      (_) {
        logAuth('Resend verification successful', success: true, data: {'email': event.email});
        emit(AuthEmailVerificationRequired(event.email));
      },
    );
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    logStateChange('Current State', 'AuthLoading', context: 'AuthBloc');
    logAuth('Logout attempt');
    
    emit(AuthLoading());
    
    final res = await _logout().run();

    res.fold(
      (failure) {
        logAuth('Logout failed', success: false, data: {'error': failure.message});
        logStateChange('AuthLoading', 'AuthFailure', context: 'AuthBloc');
        emit(AuthFailure(failure.message));
      },
      (_) {
        logAuth('Logout successful', success: true);
        logStateChange('AuthLoading', 'AuthInitial', context: 'AuthBloc');
        emit(AuthInitial());
      },
    );
  }
}
