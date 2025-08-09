import 'package:agora/core/errors/failures.dart';
import 'package:agora/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';


@injectable
class IsAuthenticated {
  final AuthRepository repository;

  IsAuthenticated(this.repository);

  TaskEither<Failure, bool> call() {
    return repository.isAuthenticated();
  }
}
