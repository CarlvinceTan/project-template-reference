import 'package:agora/core/errors/failures.dart';
import 'package:agora/features/auth/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  TaskEither<Failure, User> loginWithEmailAndPassword({required String email, required String password});

  TaskEither<Failure, User> signupWithEmailAndPassword({required String email, required String password});

  TaskEither<Failure, User> restorePassword({required String email});

  TaskEither<Failure, User> verifyEmail({required String email, required String verificationCode});

  TaskEither<Failure, void> resendVerificationEmail({required String email});

  TaskEither<Failure, void> logout();

  TaskEither<Failure, bool> isAuthenticated();
}