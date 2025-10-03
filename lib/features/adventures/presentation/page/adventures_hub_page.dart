import 'package:flutter/material.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/features/adventures/presentation/page/adventure_detail_page.dart';
import 'package:life_tracking/features/adventures/presentation/widgets/add_adventure_modal.dart';

class AdventuresHubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Adventures & Challenges',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddAdventureModal(),
                  );
                },
              ),
            ],
          ),
          Divider(),
          SizedBox(height: 16),

          // 2024 Misogi Challenge
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('🎯', style: TextStyle(fontSize: 24)),
                      SizedBox(width: 8),
                      Text(
                        '2024 Misogi Challenge',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('Climb 5 Mountain Peaks'),
                  SizedBox(height: 8),
                  Row(children: [Text('Progress: '), Text('●●●○○ (3/5)')]),
                  SizedBox(height: 8),
                  Text('Next: Mount Washington'),
                  Text('Training days: 89'),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AdventureDetailPage(),
                          ),
                        ),
                        child: Text('View Progress'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(onPressed: () {}, child: Text('Log Day')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),

          // Active Adventures
          Text(
            '🏔️ Active Adventures',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Visit Japan
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (val) {}),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Visit Japan'),
                            Text('Target: By age 35 (7 yrs)'),
                            Text('Progress: Planning phase'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  // Learn Spanish
                  Row(
                    children: [
                      Checkbox(value: false, onChanged: (val) {}),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Learn Spanish'),
                            Text('Target: Conversational'),
                            Text('Progress: 45 days streak'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  // Run Marathon
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (val) {}),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Run Marathon'),
                            Text('Completed: Oct 2023'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),

          // Suggested Adventures
          Text(
            '💡 Suggested Adventures',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Based on your interests:'),
                  SizedBox(height: 8),
                  Text('• Learn Photography'),
                  Text('• Weekend Camping Trip'),
                  Text('• Visit Local Art Museum'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('See All Suggestions'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),

          // Deadline Reminders
          Text(
            '⏰ Deadline Reminders',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('• Japan trip: Research by Dec'),
          Text('• Marathon training: Start Oct'),
          SizedBox(height: 24),

          // View All
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouts.adventureGallery);
              },
              child: Text('View All 23 Adventures'),
            ),
          ),
          SizedBox(height: 16),

          // This Year
          Center(
            child: Text(
              '🏆 This Year: 3 Completed',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
