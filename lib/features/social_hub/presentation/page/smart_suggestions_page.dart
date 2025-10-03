import 'package:flutter/material.dart';

class SmartSuggestionsPage extends StatelessWidget {
  const SmartSuggestionsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("This Week's Ideas"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey[50]!],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '💡 Personalized for You',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildSuggestionCard(
                icon: '👨‍👧',
                title: 'Family Time',
                description:
                    "Emma's soccer game tomorrow\n(You haven't missed one yet this season! 🏆)",
                buttons: ['Add to Calendar'],
              ),
              SizedBox(height: 16),
              _buildSuggestionCard(
                icon: '🏔️',
                title: 'Adventure Progress',
                description:
                    "Perfect weather Saturday for Mount Washington hike training (72°F, sunny)",
                buttons: ['Plan Training Hike'],
              ),
              SizedBox(height: 16),
              _buildSuggestionCard(
                icon: '👥',
                title: 'Relationship Nudges',
                description:
                    "It's been 5 days since you called Mom. She mentioned wanting to share her apple pie recipe.",
                buttons: ['Call Mom', 'Schedule Cook'],
              ),
              SizedBox(height: 16),
              _buildSuggestionCard(
                icon: '📚',
                title: 'Growth Opportunities',
                description:
                    "You've kept your Spanish streak for 45 days! Try having a 5-minute convo with a native speaker.",
                buttons: ['Find Language Exchange'],
              ),
              SizedBox(height: 16),
              Text(
                '✨ New Adventure Ideas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              _buildAdventureIdeas(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionCard({
    required String icon,
    required String title,
    required String description,
    required List<String> buttons,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$icon $title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 12),
            Row(
              children: buttons
                  .map(
                    (button) => Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(button),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
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

  Widget _buildAdventureIdeas() {
    List<String> ideas = [
      'Weekend camping trip',
      'Photography class',
      'Volunteer at animal shelter',
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...ideas.map(
          (idea) => Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text('• $idea', style: TextStyle(fontSize: 16)),
          ),
        ),
        SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {},
          child: Text('Explore More Ideas'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[600],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
