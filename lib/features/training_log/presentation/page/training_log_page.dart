import 'package:flutter/material.dart';

class TrainingLogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Training Log'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
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
                'Mount Washington Training',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Target: September 15, 2024',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              Text(
                '🎯 Training Schedule',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text('Week 1-4: Base Building'),
              Text('Week 5-8: Hill Training'),
              Text('Week 9-12: Peak Preparation'),
              SizedBox(height: 20),
              Text(
                '📊 Progress This Week',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(children: [Text('Cardio: '), Text('●●●○○ (3/5 days)')]),
                    SizedBox(height: 8),
                    Row(
                      children: [Text('Hiking: '), Text('●●○○ (2/4 sessions)')],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [Text('Strength: '), Text('●●●●○ (4/5 days)')],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                '📝 Recent Sessions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Today • Hill Repeats'),
                      Text('45 min • 850 ft elevation'),
                      Text('"Legs felt strong today!"'),
                      Text('⚡ Great effort'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('2 days ago • Long Hike'),
                      Text('3.2 hours • 1,200 ft'),
                      Text('"Beautiful sunrise view"'),
                      Text('📸 [2 photos]'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '🏆 Milestones',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Column(
                children: [
                  Row(children: [Text('✓ First 3-hour hike completed')]),
                  Row(children: [Text('○ 1,500 ft elevation gain')]),
                  Row(children: [Text('○ 15-pound pack carried')]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
