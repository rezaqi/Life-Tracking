import 'package:life_tracking/features/auth/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  /// حفظ بيانات المستخدم
  static Future<void> saveUserData({
    required String id,
    required String email,
    required String name,
    required int age,
    required String birthday,
    required int lifeExpectancy,
    required String relationship,
    required List<String> goals,
    required String country,
    required String gender,
    required String haveChildren, // جديد
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", id);
    await prefs.setString("email", email);
    await prefs.setString("name", name);
    await prefs.setInt("age", age);
    await prefs.setString("birthday", birthday);
    await prefs.setInt("life_expectancy", lifeExpectancy);
    await prefs.setString("relationship", relationship);
    await prefs.setStringList("goals", goals);
    await prefs.setString("country", country);
    await prefs.setString("gender", gender);
    await prefs.setString("have_children", haveChildren); // جديد
  }

  /// جلب بيانات المستخدم
  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');
    final email = prefs.getString('email');
    final name = prefs.getString('name');
    final age = prefs.getInt('age');
    final birthday = prefs.getString('birthday');
    final lifeExpectancy = prefs.getInt('life_expectancy') ?? 90;
    final relationship = prefs.getString('relationship') ?? "";
    final goals = prefs.getStringList('goals') ?? [];
    final country = prefs.getString('country') ?? "";
    final gender = prefs.getString('gender') ?? "";
    final haveChildren = prefs.getString('have_children') ?? ""; // جديد

    if (id != null && email != null && name != null) {
      return UserModel(
        id: id,
        email: email,
        name: name,
        age: age ?? 0,
        birthday: birthday ?? '',
        lifeExpectancy: lifeExpectancy,
        relationship: relationship,
        goals: goals,
        country: country,
        gender: gender,
        haveChildren: haveChildren, // جديد
        pass: '',
      );
    }
    return null; // لا يوجد مستخدم محفوظ
  }

  /// حذف بيانات المستخدم
  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
