import 'package:flutter/material.dart';

class NotificationsModal extends StatelessWidget {
  const NotificationsModal({super.key});

  static const List<Map<String, dynamic>> notifications = [
    {
      'icon': '🏔️',
      'title': 'Adventure Reminder',
      'message': 'Only 89 days left to complete your Mount Washington climb!',
      'buttons': ['View Progress', 'Dismiss'],
    },
    {
      'icon': '👥',
      'title': 'Relationship Nudge',
      'message': 'It\'s been 5 days since you called Mom. Sunday dinner?',
      'buttons': ['Call Now', 'Schedule Later'],
    },
    {
      'icon': '📅',
      'title': 'Weekly Reflection',
      'message': 'Time for your weekly check-in! How did this week go?',
      'buttons': ['Reflect Now', 'Remind Tomorrow'],
    },
    {
      'icon': '🎉',
      'title': 'Milestone Celebration',
      'message': 'You\'ve captured 250 precious moments this year! 🎊',
      'buttons': ['Share Achievement', 'View All'],
    },
    {
      'icon': '💡',
      'title': 'Inspiration',
      'message':
          'You have 847 weekends with Emma before she turns 18. Make this one count!',
      'buttons': ['Plan Activity', 'Add to Calendar'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    '🔔 Notifications',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notif = notifications[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notif['icon'],
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notif['title'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(notif['message']),
                                const SizedBox(height: 8),
                                Row(
                                  children: (notif['buttons'] as List<String>)
                                      .map((button) {
                                        return Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    '$button pressed',
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(button),
                                          ),
                                        );
                                      })
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
