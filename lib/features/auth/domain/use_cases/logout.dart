import 'package:agora/core/errors/failures.dart';
import 'package:agora/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

@injectable
class Logout {
  final AuthRepository repository;

  Logout(this.repository);

  TaskEither<Failure, void> call() {
    return repository.logout();
  }
}
