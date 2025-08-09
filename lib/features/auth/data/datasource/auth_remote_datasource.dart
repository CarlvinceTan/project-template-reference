import 'package:agora/core/errors/exceptions.dart';
import 'package:agora/features/auth/data/models/user_model.dart';
import 'package:agora/core/logging/logger.dart';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> restorePassword({required String email});

  Future<UserModel> verifyEmail({required String email, required String verificationCode});

  Future<void> resendVerificationEmail({required String email});

  Future<void> logout();

  Future<bool> isAuthenticated();
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      logNetwork('POST', '/auth/v1/signup', data: {'email': email});
      
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
      
      logInfo('Signup response received', type: LogType.auth, data: {
        'user_id': response.user?.id,
        'email_confirmed': response.user?.emailConfirmedAt != null,
        'confirmation_sent_at': response.user?.confirmationSentAt,
      });
      
      if (response.user == null) {
        logError('Signup failed: User is null', type: LogType.auth);
        throw const ServerException('User is null');
      }
      
      logAuth('Signup successful', success: true, data: {
        'user_id': response.user!.id,
        'email': response.user!.email,
        'needs_verification': response.user!.emailConfirmedAt == null,
      });
      
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      logError('Signup failed', type: LogType.auth, error: e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> restorePassword({required String email}) async {
    try {
      await supabaseClient.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> verifyEmail({required String email, required String verificationCode}) async {
    try {
      logNetwork('POST', '/auth/v1/verify', data: {'email': email, 'token_length': verificationCode.length});
      
      final response = await supabaseClient.auth.verifyOTP(
        email: email,
        token: verificationCode,
        type: OtpType.email,
      );
      
      logInfo('Email verification response received', type: LogType.auth, data: {
        'user_id': response.user?.id,
        'email_confirmed': response.user?.emailConfirmedAt != null,
        'session_exists': response.session != null,
      });
      
      if (response.user == null) {
        logError('Email verification failed: User is null', type: LogType.auth);
        throw const ServerException('User is null');
      }
      
      logAuth('Email verification successful', success: true, data: {
        'user_id': response.user!.id,
        'email': response.user!.email,
      });
      
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      logError('Email verification failed', type: LogType.auth, error: e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> resendVerificationEmail({required String email}) async {
    try {
      logNetwork('POST', '/auth/v1/resend', data: {'email': email, 'type': 'signup'});
      
      await supabaseClient.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      
      logAuth('Resend verification email successful', success: true, data: {'email': email});
    } catch (e) {
      logError('Resend verification email failed', type: LogType.auth, error: e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final session = supabaseClient.auth.currentSession;
      return session != null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
