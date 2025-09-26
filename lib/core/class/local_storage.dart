import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUserData({
    required String name,
    required String birthday,
    required int lifeExpectancy,
    required String relationship,
    required List<String> goals,
    required String haveChildren,
    required String country,
    required String partnerName,
    required String partnerBirthday,
    required String anniversary,
    required List<Map<String, dynamic>> children,
    // String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("user_name", name);
    await prefs.setString("user_birthday", birthday);
    await prefs.setInt("user_life_expectancy", lifeExpectancy);
    await prefs.setString("user_relationship", relationship);
    await prefs.setStringList("user_goals", goals);
    await prefs.setString("user_have_children", haveChildren);
    await prefs.setString("user_country", country);
    await prefs.setString("user_partner_name", partnerName);
    await prefs.setString("user_partner_birthday", partnerBirthday);
    await prefs.setString("user_anniversary", anniversary);
    //  await prefs.setString("user_email", email);

    // ✅ حفظ الأبناء (لأن SharedPreferences مش بيدعم List<Map> لازم نحولها JSON)
    String childrenJson = jsonEncode(children);
    await prefs.setString("user_children", childrenJson);
  }

  static Future<Map<String, dynamic>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // ✅ استرجاع الأبناء من JSON
    String? childrenJson = prefs.getString("user_children");
    List<Map<String, dynamic>> children = [];
    if (childrenJson != null && childrenJson.isNotEmpty) {
      children = List<Map<String, dynamic>>.from(jsonDecode(childrenJson));
    }

    return {
      "name": prefs.getString("user_name") ?? "",
      "birthday": prefs.getString("user_birthday") ?? "",
      "lifeExpectancy": prefs.getInt("user_life_expectancy") ?? 90,
      "relationship": prefs.getString("user_relationship") ?? "",
      "goals": prefs.getStringList("user_goals") ?? [],
      "haveChildren": prefs.getString("user_have_children") ?? "",
      "country": prefs.getString("user_country") ?? "",
      "partnerName": prefs.getString("user_partner_name") ?? "",
      "partnerBirthday": prefs.getString("user_partner_birthday") ?? "",
      "anniversary": prefs.getString("user_anniversary") ?? "",
      //  "email": prefs.getString("user_email") ?? "",
      "children": children,
    };
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
