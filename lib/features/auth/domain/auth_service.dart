import 'package:flutter/material.dart';

import 'user.dart';

abstract class AuthService {
  Future<void> signUp(
    String email,
    String password,
    String username,
    String birthday,
    int lifeExpectancy,
    String relationship,
    List<String> goals,
    String haveChildren,
    String country,
    List<Map<String, dynamic>> children,
    String partnerName,
    String partnerBirthday,
    String anniversary,
  );
  Future<void> login(String email, String password);
  Future<void> logout(BuildContext context);
  Future<UserModel?> getCurrentUser();
  Stream<UserModel?> get authStateChanges;
}
