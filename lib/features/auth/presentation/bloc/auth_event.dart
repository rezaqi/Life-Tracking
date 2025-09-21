abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

class LogoutRequested extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  // 👈 جديد
  final String email;
  final String password;
  final String username;
  SignUpRequested(this.email, this.password, this.username);
}
