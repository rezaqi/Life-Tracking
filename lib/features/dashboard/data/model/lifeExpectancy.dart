class LifeExpectancyModel {
  final int male;
  final int female;
  final int general;

  LifeExpectancyModel({
    required this.male,
    required this.female,
    required this.general,
  });

  factory LifeExpectancyModel.fromFirestore(Map<String, dynamic> json) {
    return LifeExpectancyModel(
      male: json['male'] ?? 0,
      female: json['female'] ?? 0,
      general: json['general'] ?? 0,
    );
  }
}
