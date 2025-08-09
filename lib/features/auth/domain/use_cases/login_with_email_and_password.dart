import 'package:agora/core/errors/failures.dart';
import 'package:agora/features/auth/domain/entities/user.dart';
import 'package:agora/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginWithEmailAndPassword {
  final AuthRepository repository;

  LoginWithEmailAndPassword(this.repository);

  TaskEither<Failure, User> call({
    required String email,
    required String password,
  }) {
    return repository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
