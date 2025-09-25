import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUserData({
    required String name,
    required String birthday,
    required int lifeExpectancy,
    required String relationship,
    required List<String> goals,
    required String haveChildren, // جديد
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_name", name);
    await prefs.setString("user_birthday", birthday);
    await prefs.setInt("user_life_expectancy", lifeExpectancy);
    await prefs.setString("user_relationship", relationship);
    await prefs.setStringList("user_goals", goals);
    await prefs.setString("user_have_children", haveChildren); // جديد
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "name": prefs.getString("user_name") ?? "",
      "birthday": prefs.getString("user_birthday") ?? "",
      "lifeExpectancy": prefs.getInt("user_life_expectancy") ?? 90,
      "relationship": prefs.getString("user_relationship") ?? "",
      "goals": prefs.getStringList("user_goals") ?? [],
      "haveChildren": prefs.getString("user_have_children") ?? "", // جديد
    };
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
