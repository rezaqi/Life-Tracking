// features/auth/domain/auth_service.dart
import 'package:injectable/injectable.dart';

abstract class AuthService {
  Future<bool> login(String email, String password);
  Future<void> logout();
  Future<bool> signUp(
    String email,
    String password,
    String username,
  ); // 👈 جديد
}

@Injectable(as: AuthService)
class MockAuthRepository implements AuthService {
  final List<Map<String, String>> _users = [];

  @override
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return _users.any((u) => u['email'] == email && u['password'] == password);
  }

  @override
  Future<void> logout() async =>
      Future.delayed(const Duration(milliseconds: 300));

  @override
  Future<bool> signUp(String email, String password, String username) async {
    await Future.delayed(const Duration(seconds: 1));
    if (_users.any((u) => u['email'] == email)) return false;
    _users.add({"email": email, "password": password, "username": username});
    return true;
  }
}
