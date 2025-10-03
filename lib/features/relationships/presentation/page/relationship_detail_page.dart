import 'package:flutter/material.dart';
import 'package:life_tracking/features/relationships/domain/model/relationship.dart';

class RelationshipDetailPage extends StatelessWidget {
  final Relationship relationship;

  const RelationshipDetailPage({Key? key, required this.relationship})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(relationship.relation),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // TODO: Add menu actions
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                CircleAvatar(radius: 30, child: Icon(Icons.person, size: 40)),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${relationship.name}, ${relationship.age}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${relationship.relation} • Lives ${relationship.distance} away',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Time Remaining Section
            Text(
              '⏰ Time Remaining',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Based on average lifespan:'),
                  SizedBox(height: 4),
                  Text(
                    '~${_calculateSundayDinners(relationship.averageLifespanYears)} Sunday dinners left',
                  ),
                  Text(
                    '~${_calculateHolidays(relationship.averageLifespanYears)} holidays together',
                  ),
                  Text(
                    '~${_calculateBirthdays(relationship.averageLifespanYears)} birthday celebrations',
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Contact History Section
            Text(
              '📞 Contact History',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 4),
            Text('Last call: ${relationship.lastCallDaysAgo} days ago'),
            Text('Last visit: ${relationship.lastVisitWeeksAgo} weeks ago'),
            Text(
              'Average contact: Every ${relationship.averageContactDays} days',
            ),
            SizedBox(height: 24),

            // Recent Memories Section
            Text(
              '📸 Recent Memories (${relationship.recentMemoriesCount})',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Container(
              height: 100,
              child: GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(relationship.recentMemoriesCount, (
                  index,
                ) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: Icon(Icons.photo, color: Colors.grey.shade600),
                  );
                }),
              ),
            ),
            SizedBox(height: 24),

            // Relationship Goals Section
            Text(
              '🎯 Relationship Goals',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.check, color: Colors.green, size: 20),
                    SizedBox(width: 8),
                    Text('Call weekly (Currently: ✓)'),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Visit monthly (Behind by ${relationship.visitGoalBehindBy})',
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  'Learn her recipes (${relationship.recipesLearned}/${relationship.recipesTotal})',
                ),
              ],
            ),
            SizedBox(height: 24),

            // Quick Actions Section
            Text(
              'Quick Actions:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.call),
                  label: Text('Call Now'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.calendar_today),
                  label: Text('Schedule Visit'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.mail),
                  label: Text('Send Message'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt),
                  label: Text('Add Memory'),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Ideas for Quality Time Section
            Text(
              'Ideas for Quality Time:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: relationship.qualityTimeIdeas
                  .map((idea) => Text('• $idea'))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateSundayDinners(int lifespanYears) {
    // Approximate 52 Sundays per year
    return lifespanYears * 52;
  }

  int _calculateHolidays(int lifespanYears) {
    // Approximate 12 major holidays per year
    return lifespanYears * 12;
  }

  int _calculateBirthdays(int lifespanYears) {
    // Approximate 1 birthday per year
    return lifespanYears;
  }
}
