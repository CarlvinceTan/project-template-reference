import 'package:agora/core/errors/failures.dart';
import 'package:agora/core/errors/exceptions.dart';
import 'package:agora/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:agora/features/auth/data/models/user_model.dart';
import 'package:agora/features/auth/domain/entities/user.dart';
import 'package:agora/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  TaskEither<Failure, User> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        final UserModel userModel = await remoteDataSource.loginWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userModel.toDomain();
      },
      (error, stackTrace) => error is ServerException 
        ? Failure(error.message)
        : Failure(error.toString()),
    );
  }

  @override
  TaskEither<Failure, User> signupWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        final UserModel userModel = await remoteDataSource.signUpWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userModel.toDomain();
      },
      (error, stackTrace) => error is ServerException 
        ? Failure(error.message)
        : Failure(error.toString()),
    );
  }

  @override
  TaskEither<Failure, User> restorePassword({required String email}) {
    return TaskEither.tryCatch(
      () async {
        await remoteDataSource.restorePassword(email: email);
        return User(id: '', email: email);
      },
      (error, stackTrace) => error is ServerException 
        ? Failure(error.message)
        : Failure(error.toString()),
    );
  }

  @override
  TaskEither<Failure, User> verifyEmail({required String email, required String verificationCode}) {
    return TaskEither.tryCatch(
      () async {
        final UserModel userModel = await remoteDataSource.verifyEmail(
          email: email,
          verificationCode: verificationCode,
        );
        return userModel.toDomain();
      },
      (error, stackTrace) => error is ServerException 
        ? Failure(error.message)
        : Failure(error.toString()),
    );
  }

  @override
  TaskEither<Failure, void> resendVerificationEmail({required String email}) {
    return TaskEither.tryCatch(
      () async {
        await remoteDataSource.resendVerificationEmail(email: email);
      },
      (error, stackTrace) => error is ServerException 
        ? Failure(error.message)
        : Failure(error.toString()),
    );
  }

  @override
  TaskEither<Failure, void> logout() {
    return TaskEither.tryCatch(
      () async {
        await remoteDataSource.logout();
      },
      (error, stackTrace) => error is ServerException 
        ? Failure(error.message)
        : Failure(error.toString()),
    );
  }

  @override
  TaskEither<Failure, bool> isAuthenticated() {
    return TaskEither.tryCatch(
      () async {
        final bool isAuthenticated = await remoteDataSource.isAuthenticated();
        return isAuthenticated;
      },
      (error, stackTrace) => error is ServerException 
        ? Failure(error.message)
        : Failure(error.toString()),
    );
  }
}

extension UserModelX on UserModel {
  User toDomain() {
    return User(
      id: id,
      email: email,
    );
  }
}
