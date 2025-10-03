import 'package:flutter/material.dart';
import 'package:life_tracking/features/moments/data/models/memory.dart';

class MemoryFeedPage extends StatelessWidget {
  const MemoryFeedPage({super.key});

  // Dummy data
  List<Memory> get _dummyMemories => [
    Memory.dummy(
      id: '1',
      date: DateTime.now().subtract(const Duration(days: 1)),
      title: "Emma's Soccer Game",
      description:
          "She scored her first goal! The joy on her face was everything.",
      photoUrl: null, // Placeholder for photo
      emoji: '👨‍👧',
    ),
    Memory.dummy(
      id: '2',
      date: DateTime.now().subtract(const Duration(days: 3)),
      title: 'Sunday Dinner with Mom',
      description:
          'Made her famous lasagna together. These recipes need to be preserved!',
      photoUrl: null,
      emoji: '👩‍👦',
    ),
    Memory.dummy(
      id: '3',
      date: DateTime.now().subtract(const Duration(days: 7)),
      title: 'Training Hike',
      description: '5 miles up Mount Tom. Building strength for Washington!',
      photoUrl: null,
      emoji: '💪',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('My Memories'),
        actions: const [Icon(Icons.person)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'This Week\'s Moments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _dummyMemories.length,
                itemBuilder: (context, index) {
                  final memory = _dummyMemories[index];
                  return _buildMemoryCard(memory);
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // TODO: Load more memories
                  },
                  child: const Text('Load More Memories'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Add new memory
                  },
                  child: const Text('+ Add New'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemoryCard(Memory memory) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Placeholder for photo
                Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
                  child: const Icon(Icons.photo, color: Colors.grey),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(memory.date),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        memory.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(memory.description),
                      const SizedBox(height: 8),
                      Text(memory.emoji, style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // TODO: Edit memory
                  },
                  child: const Text('Edit'),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () {
                    // TODO: Share to social
                  },
                  child: const Text('Share to Social'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else if (difference == 7) {
      return '1 week ago';
    } else {
      return '${(difference / 7).floor()} weeks ago';
    }
  }
}
