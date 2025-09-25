class DayModel {
  final String id; // id بتاع الدوك
  final String title;
  final String description;
  final String mood;
  final List<String> imageUrls; // لينكات الصور
  final String date; // نخزنها كـ yyyy-MM-dd
  final String userId;

  DayModel({
    required this.id,
    required this.title,
    required this.description,
    required this.mood,
    required this.imageUrls,
    required this.date,
    required this.userId,
  });

  /// تحويل من Firebase Document -> DayModel
  factory DayModel.fromMap(Map<String, dynamic> map, {String? docId}) {
    return DayModel(
      id: docId ?? map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      mood: map['mood'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      date: map['date'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  /// تحويل لـ Firebase
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'mood': mood,
      'imageUrls': imageUrls,
      'date': date,
      'userId': userId,
    };
  }
}
