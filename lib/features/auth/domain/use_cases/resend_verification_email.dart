import 'package:agora/core/errors/failures.dart';
import 'package:agora/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResendVerificationEmail {
  final AuthRepository repository;

  ResendVerificationEmail(this.repository);

  TaskEither<Failure, void> call({
    required String email,
  }) {
    return repository.resendVerificationEmail(email: email);
  }
}
