class Memory {
  final String id;
  final DateTime date;
  final String title;
  final String description;
  final String? photoUrl;
  final String emoji;

  Memory({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    this.photoUrl,
    required this.emoji,
  });

  // Factory for dummy data
  factory Memory.dummy({
    required String id,
    required DateTime date,
    required String title,
    required String description,
    String? photoUrl,
    required String emoji,
  }) {
    return Memory(
      id: id,
      date: date,
      title: title,
      description: description,
      photoUrl: photoUrl,
      emoji: emoji,
    );
  }
}
