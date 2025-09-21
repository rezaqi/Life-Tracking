// features/auth/data/services/auth_service.dart
import 'package:life_tracking/features/auth/data/models/user.dart';

class AuthService {
  UserModel? _user;
  final List<UserModel> _users = []; // 👈 عشان نعمل حسابات جديدة ونخزنها مؤقت

  /// تسجيل الدخول
  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    try {
      final user = _users.firstWhere(
        (u) => u.email == email && u.pass == password,
      );
      _user = user;
      return _user;
    } catch (e) {
      return null; // فشل تسجيل الدخول
    }
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _user = null;
  }

  /// إنشاء حساب جديد
  Future<UserModel?> signUp(
    String email,
    String password,
    String username,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    // تأكد إن الايميل مش مستخدم قبل كده
    final exists = _users.any((u) => u.email == email);
    if (exists) return null;

    final newUser = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      name: username,
      pass: password,
    );

    _users.add(newUser);
    _user = newUser;
    return _user;
  }

  /// المستخدم الحالي
  UserModel? get currentUser => _user;
}
