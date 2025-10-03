import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/core/utils/firestore_retry.dart';
import 'package:life_tracking/features/auth/domain/auth_service.dart';
import 'package:life_tracking/features/auth/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: AuthService)
class FirebaseAuthService implements AuthService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', user.id);
    await prefs.setString('email', user.email);
    await prefs.setString('name', user.name);
    await prefs.setInt('age', user.age);
    await prefs.setString('gender', user.gender);
    await prefs.setString('country', user.country);
    await prefs.setBool('onboarding_seen', true);
  }

  Future<void> _clearUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Future<UserModel?> signUp(
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
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(username);

      final user = credential.user;
      if (user != null) {
        DateTime? birthDate;
        try {
          birthDate = DateTime.parse(birthday);
        } catch (_) {}
        int age = 0;
        if (birthDate != null) {
          DateTime today = DateTime.now();
          age = today.year - birthDate.year;
          if (today.month < birthDate.month ||
              (today.month == birthDate.month && today.day < birthDate.day)) {
            age--;
          }
        }

        final newUser = UserModel(
          id: user.uid,
          email: email,
          name: username,
          birthday: birthday,
          age: age,
          lifeExpectancy: lifeExpectancy,
          relationship: relationship,
          goals: goals,
          country: country,
          haveChildren: haveChildren,
          gender: '',
          pass: '',
        );

        await _firestore.collection("users").doc(user.uid).set({
          "id": user.uid,
          "email": email,
          "name": username,
          "birthday": birthday,
          "age": age,
          "lifeExpectancy": lifeExpectancy,
          "relationship": relationship,
          "goals": goals,
          "haveChildren": haveChildren,
          "country": country,
          "children": children,
          "partnerName": partnerName,
          "partnerBirthday": partnerBirthday,
          "anniversary": anniversary,
          "createdAt": FieldValue.serverTimestamp(),
        });

        // حفظ محلي
        await _saveUserToPrefs(newUser);

        return newUser;
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
    return null;
  }

  // Extended sign-up with full profile details (not part of AuthService interface)
  Future<UserModel?> signUpWithDetails(
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
  ) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(username);

      final user = credential.user;
      if (user != null) {
        DateTime? birthDate;
        try {
          birthDate = DateTime.parse(birthday);
        } catch (_) {}
        int age = 0;
        if (birthDate != null) {
          DateTime today = DateTime.now();
          age = today.year - birthDate.year;
          if (today.month < birthDate.month ||
              (today.month == birthDate.month && today.day < birthDate.day)) {
            age--;
          }
        }

        final newUser = UserModel(
          id: user.uid,
          email: email,
          name: username,
          birthday: birthday,
          age: age,
          lifeExpectancy: lifeExpectancy,
          relationship: relationship,
          goals: goals,
          country: country,
          haveChildren: haveChildren,
          gender: '',
          pass: '',
        );

        await retryFirestoreOperation(() async {
          await _firestore.collection("users").doc(user.uid).set({
            "id": user.uid,
            "email": email,
            "name": username,
            "birthday": birthday,
            "age": age,
            "lifeExpectancy": lifeExpectancy,
            "relationship": relationship,
            "goals": goals,
            "haveChildren": haveChildren,
            "country": country,
            "children": children,
            "partnerName": partnerName,
            "partnerBirthday": partnerBirthday,
            "anniversary": anniversary,
            "createdAt": FieldValue.serverTimestamp(),
          });
        });

        // حفظ محلي
        await _saveUserToPrefs(newUser);
        return newUser;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> login(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user;
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', user.uid);
      await prefs.setString('email', user.email ?? '');
      await prefs.setString('name', user.displayName ?? '');
    }
  }

  @override
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    await _clearUserPrefs();
    Navigator.pushNamedAndRemoveUntil(context, AppRouts.login, (r) => false);
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;
    return firebaseUser != null ? UserModel.fromFirebase(firebaseUser) : null;
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return _auth.authStateChanges().map(
      (firebaseUser) =>
          firebaseUser != null ? UserModel.fromFirebase(firebaseUser) : null,
    );
  }
}
