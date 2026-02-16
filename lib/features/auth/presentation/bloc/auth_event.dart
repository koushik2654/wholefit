abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested({required this.email, required this.password});
}

class CheckAuthStatus extends AuthEvent {}

class LogoutRequested extends AuthEvent {}