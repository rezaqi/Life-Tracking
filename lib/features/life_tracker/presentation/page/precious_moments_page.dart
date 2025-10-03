import 'package:flutter/material.dart';

class PreciousMomentsPage extends StatelessWidget {
  const PreciousMomentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Precious Moments'),
        actions: const [Icon(Icons.person)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(children: [Text('⏰ Time Remaining')]),
            const SizedBox(height: 16),
            // Relationship cards
            _buildRelationshipCard(
              name: 'With Emma (daughter, age 8)',
              countdowns: [
                '520 weekends until 18',
                '~2,600 bedtime stories',
                '780 soccer games to watch',
              ],
              lastContact: 'Last quality time: 2 days',
              buttons: ['Plan Activity', 'Add Memory'],
            ),
            const SizedBox(height: 16),
            _buildRelationshipCard(
              name: 'With Mom (age 67)',
              countdowns: ['~936 Sunday dinners left', '156 holidays together'],
              lastContact: 'Last contact: 5 days ago',
              buttons: ['Call Mom', 'Schedule Visit'],
            ),
            const SizedBox(height: 16),
            _buildRelationshipCard(
              name: 'With Sarah (wife)',
              countdowns: [
                '1,820 date nights until 40',
                '15th anniversary: 956 days',
              ],
              lastContact: '',
              buttons: ['Plan Date', 'Add Memory'],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to view all relationships
                },
                child: const Text('View All Relationships'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelationshipCard({
    required String name,
    required List<String> countdowns,
    required String lastContact,
    required List<String> buttons,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...countdowns.map(
              (countdown) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(countdown),
              ),
            ),
            if (lastContact.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(lastContact),
            ],
            const SizedBox(height: 12),
            Row(
              children: buttons
                  .map(
                    (button) => Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          // TODO: Implement button actions
                        },
                        child: Text(button),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
