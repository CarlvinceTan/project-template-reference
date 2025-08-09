part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;

  const AuthSignUp({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class AuthRestorePassword extends AuthEvent {
  final String email;

  const AuthRestorePassword({required this.email});

  @override
  List<Object> get props => [email];
}

final class AuthVerifyEmail extends AuthEvent {
  final String email;
  final String verificationCode;

  const AuthVerifyEmail({required this.email, required this.verificationCode});

  @override
  List<Object> get props => [email, verificationCode];
}

final class AuthResendVerification extends AuthEvent {
  final String email;

  const AuthResendVerification({required this.email});

  @override
  List<Object> get props => [email];
}

final class AuthLogout extends AuthEvent {
  const AuthLogout();
}
