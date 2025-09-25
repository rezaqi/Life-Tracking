class UserModel {
  final String id;
  final String email;
  final String name;
  final int age;
  final String birthday;
  final int lifeExpectancy;
  final String relationship;
  final List<String> goals;
  final String country;
  final String gender;
  final String haveChildren; // جديد
  final String pass;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.age,
    required this.birthday,
    this.lifeExpectancy = 90,
    this.relationship = '',
    this.goals = const [],
    this.country = '',
    this.gender = '',
    this.haveChildren = '', // جديد
    required this.pass,
  });
}
