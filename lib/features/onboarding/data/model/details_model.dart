class DetailsUserModel {
  final int age;
  final String country;
  final String gender;
  final List<String> importantRelations;
  final List<String> lifeGoals;
  final List<String> bucketList;

  DetailsUserModel({
    required this.age,
    required this.country,
    required this.gender,
    required this.importantRelations,
    required this.lifeGoals,
    required this.bucketList,
  });

  Map<String, dynamic> toMap() {
    return {
      'age': age,
      'country': country,
      'gender': gender,
      'importantRelations': importantRelations,
      'lifeGoals': lifeGoals,
      'bucketList': bucketList,
    };
  }

  factory DetailsUserModel.fromMap(Map<String, dynamic> map) {
    return DetailsUserModel(
      age: map['age'],
      country: map['country'],
      gender: map['gender'],
      importantRelations: List<String>.from(map['importantRelations'] ?? []),
      lifeGoals: List<String>.from(map['lifeGoals'] ?? []),
      bucketList: List<String>.from(map['bucketList'] ?? []),
    );
  }
}
