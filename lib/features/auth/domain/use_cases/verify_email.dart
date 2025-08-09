import 'package:agora/core/errors/failures.dart';
import 'package:agora/features/auth/domain/entities/user.dart';
import 'package:agora/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyEmail {
  final AuthRepository repository;

  VerifyEmail(this.repository);

  TaskEither<Failure, User> call({
    required String email,
    required String verificationCode,
  }) {
    return repository.verifyEmail(
      email: email,
      verificationCode: verificationCode,
    );
  }
}
