// features/auth/data/services/auth_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:life_tracking/features/auth/data/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// تسجيل الدخول
  Future<UserModel?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user != null) {
        return UserModel(
          id: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
          pass: '', // مش هتخزن الباسورد
        );
      }
    } on FirebaseAuthException catch (e) {
      print("Login error: ${e.message}");
    }
    return null;
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// إنشاء حساب جديد
  Future<UserModel?> signUp(
    String email,
    String password,
    String username, {
    int? age, // Optional: add age when signing up
  }) async {
    try {
      // Create user with Firebase Authentication
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name in Firebase Auth
      await credential.user?.updateDisplayName(username);

      final user = credential.user;
      if (user != null) {
        final newUser = UserModel(
          id: user.uid,
          email: user.email ?? '',
          name: username,
          pass: '', // Don't store password locally
        );

        // ✅ Save user data to Firestore
        await _firestore.collection("users").doc(user.uid).set({
          "id": user.uid,
          "email": user.email,
          "name": username,
          "age": age, // Can be null if not provided
          "createdAt": FieldValue.serverTimestamp(),
        });

        return newUser;
      }
    } on FirebaseAuthException catch (e) {
      print("Signup error: ${e.message}");
    }
    return null;
  }

  /// المستخدم الحالي
  UserModel? get currentUser {
    final user = _auth.currentUser;
    if (user != null) {
      return UserModel(
        id: user.uid,
        email: user.email ?? '',
        name: user.displayName ?? '',
        pass: '',
      );
    }
    return null;
  }
}
