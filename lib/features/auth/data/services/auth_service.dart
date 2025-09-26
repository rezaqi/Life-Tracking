// features/auth/data/services/auth_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:life_tracking/features/auth/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _saveUserToPrefs(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', user.id);
    await prefs.setString('email', user.email);
    await prefs.setString('name', user.name);
    await prefs.setInt('age', user.age);
    await prefs.setString('gender', user.gender);
    await prefs.setString('country', user.country);
  }

  Future<void> _clearUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('email');
    await prefs.remove('name');
    await prefs.remove('age');
  }

  /// تسجيل الدخول
  Future<UserModel?> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;

      if (user != null) {
        var u = await _firestore.collection("users").doc(user.uid).get();
        UserModel userModel = UserModel(
          lifeExpectancy: u.data()?['lifeExpectancy'] ?? 0,

          id: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? '',
          birthday: u.data()?['birthday'] ?? '',
          pass: '',
          age: u.data()?["age"] ?? 0,
          gender: u.data()?['gender'] ?? '',
          country: u.data()?['country'] ?? '',
          relationship: u.data()?['relationship'] ?? '',
          goals: u.data()?['goals'] ?? [],
        );

        // حفظ بيانات المستخدم محلياً
        await _saveUserToPrefs(userModel);

        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      print("Login error: ${e.message}");
    }
    return null;
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    await _auth.signOut();
    await _clearUserPrefs();
  }

  Future<UserModel?> signUp(
    //  BuildContext context,
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
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
    return null;
  }

  /// المستخدم الحالي من Firebase + SharedPreferences
  Future<UserModel?> currentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      var snapshot = await _firestore.collection("users").doc(user.uid).get();
      var data = snapshot.data();
      if (data != null) {
        UserModel userModel = UserModel(
          lifeExpectancy: data['lifeExpectancy'] ?? 0,
          birthday: data['birthday'] ?? '',
          id: user.uid,
          email: user.email ?? '',
          name: user.displayName ?? data['name'] ?? '',
          pass: '',
          age: data['age'] ?? 0,
          gender: data['gender'] ?? '',
          country: data['country'] ?? '',
          relationship: data['relationship'] ?? '',
          goals: data['goals'] ?? [],
        );

        await _saveUserToPrefs(userModel);
        return userModel;
      }
    }
    return null;
  }
}
