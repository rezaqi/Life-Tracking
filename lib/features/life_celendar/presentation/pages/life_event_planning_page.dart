import 'package:flutter/material.dart';

class LifeEventPlanningPage extends StatelessWidget {
  LifeEventPlanningPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> events = [
    {"title": "Birthday", "date": DateTime.now().add(Duration(days: 30))},
    {"title": "Anniversary", "date": DateTime.now().add(Duration(days: 60))},
    {"title": "Vacation", "date": DateTime.now().add(Duration(days: 90))},
  ];

  String _daysRemaining(DateTime eventDate) {
    final now = DateTime.now();
    final difference = eventDate.difference(now).inDays;
    if (difference < 0) {
      return "Event passed";
    }
    return "$difference days remaining";
  }

  void _showAddEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Event"),
        content: Text("Feature coming soon."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Life Event Planning"), leading: BackButton()),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  title: Text(event["title"]),
                  subtitle: Text(_daysRemaining(event["date"])),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _showAddEventDialog(context),
              child: Text("Add New Event"),
            ),
          ),
        ],
      ),
    );
  }
}
