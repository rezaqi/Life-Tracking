class Validators {
  static String? email(String? val) {
    if (val == null || val.isEmpty) {
      return "البريد الإلكتروني مطلوب";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(val)) {
      return "البريد الإلكتروني غير صالح";
    }
    return null;
  }

  static String? password(String? val) {
    if (val == null || val.isEmpty) {
      return "كلمة المرور مطلوبة";
    }
    if (val.length < 6) {
      return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
    }
    return null;
  }

  static String? name(String? val) {
    if (val == null || val.isEmpty) {
      return "الاسم مطلوب";
    }
    if (val.length < 3) {
      return "الاسم يجب أن يكون 3 أحرف على الأقل";
    }
    final nameRegex = RegExp(r'^[a-zA-Zأ-ي\s]+$');
    if (!nameRegex.hasMatch(val)) {
      return "الاسم يجب أن يحتوي على حروف فقط";
    }
    return null;
  }

  static String? age(String? val) {
    if (val == null || val.isEmpty) {
      return "العمر مطلوب";
    }
    final num? age = int.tryParse(val);
    if (age == null) {
      return "العمر يجب أن يكون رقمًا صحيحًا";
    }
    if (age < 10 || age > 150) {
      return "العمر يجب أن يكون بين 10 و 150 سنة";
    }
    return null;
  }
}
