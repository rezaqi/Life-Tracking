// ...existing code...
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_tracking/core/class/shared_preferences.dart';
import 'package:life_tracking/features/auth/data/models/user.dart';
import 'package:life_tracking/features/life_celendar/presentation/widgets/life_progress_page.dart';

class LifeTrackerHome extends StatelessWidget {
  const LifeTrackerHome({super.key});

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Widget _quickStat(IconData icon, String value, String label) {
    return Expanded(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 28),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // استخدم FutureBuilder لقراءة المستخدم بشكل غير متزامن
    return FutureBuilder<UserModel?>(
      future:
          UserPrefs.getUser(), // [`UserPrefs.getUser`](lib/core/class/shared_preferences.dart)
      builder: (context, snapshot) {
        final userName = (snapshot.hasData && snapshot.data != null)
            ? snapshot.data!.name
            : 'Guest';

        return Scaffold(
          // شريط علوي مشابه للمثال
          appBar: AppBar(
            toolbarHeight: 64,
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            title: Row(
              children: [
                const Icon(Icons.access_time, size: 22),
                const SizedBox(width: 8),
                const Text(
                  'Life Tracker',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 14,
                  child: const Icon(Icons.person, size: 16),
                ),
                const SizedBox(width: 8),
                Text(
                  userName,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _onRefresh,

            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Your Life at a Glance',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(height: 150.h, child: LifeProgressWidget()),

                  const SizedBox(height: 18),

                  // This Week's Focus
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text('💡', style: TextStyle(fontSize: 20)),
                              SizedBox(width: 8),
                              Text(
                                "This Week's Focus",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          const Text('• Plan your next adventure'),
                          const SizedBox(height: 6),
                          const Text('• Call your parents'),
                          const SizedBox(height: 6),
                          const Text(
                            "• Book that trip you've been thinking about",
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Quick Stats:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _quickStat(Icons.terrain, '3/12', 'Advent'),
                      const SizedBox(width: 8),
                      _quickStat(Icons.family_restroom, '847', 'Moments'),
                      const SizedBox(width: 8),
                      _quickStat(Icons.calendar_month, '1,247', 'Weeks'),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
// ...existing code...