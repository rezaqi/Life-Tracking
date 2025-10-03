// ...existing code...
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/core/class/shared_preferences.dart';
import 'package:life_tracking/features/auth/domain/user.dart';
import 'package:life_tracking/features/life_celendar/presentation/widgets/life_progress_page.dart';
import 'package:life_tracking/features/life_tracker/presentation/widgets/empty_state.dart';
import 'package:life_tracking/features/life_tracker/presentation/widgets/error_state.dart';
import 'package:life_tracking/features/life_tracker/presentation/widgets/guidance_modal.dart';
import 'package:life_tracking/features/life_tracker/presentation/widgets/loading_state.dart';
import 'package:life_tracking/features/life_tracker/presentation/widgets/notifications_modal.dart';
import 'package:life_tracking/features/life_tracker/presentation/widgets/weekly_reflection_modal.dart';

enum LifeTrackerUIState { loading, empty, error, content }

class LifeTrackerHome extends StatefulWidget {
  const LifeTrackerHome({super.key});

  @override
  State<LifeTrackerHome> createState() => _LifeTrackerHomeState();
}

class _LifeTrackerHomeState extends State<LifeTrackerHome> {
  LifeTrackerUIState _uiState = LifeTrackerUIState.content;

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  Widget _quickStat(
    void Function()? ontap,
    IconData icon,
    String value,
    String label,
  ) {
    return Expanded(
      child: InkWell(
        onTap: ontap,
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
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(label, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: UserPrefs.getUser(),
      builder: (context, snapshot) {
        final userName = (snapshot.hasData && snapshot.data != null)
            ? snapshot.data!.name
            : 'Guest';

        Widget contentWidget;

        switch (_uiState) {
          case LifeTrackerUIState.loading:
            contentWidget = const LoadingStateWidget();
            break;
          case LifeTrackerUIState.empty:
            contentWidget = EmptyStateWidget(
              message: 'No life data found.',
              buttonText: 'Reload',
              onButtonPressed: () {
                setState(() {
                  _uiState = LifeTrackerUIState.content;
                });
              },
            );
            break;
          case LifeTrackerUIState.error:
            contentWidget = ErrorStateWidget(
              errorMessage: 'Failed to load life data.',
              onRetry: () {
                setState(() {
                  _uiState = LifeTrackerUIState.content;
                });
              },
            );
            break;
          case LifeTrackerUIState.content:
            contentWidget = SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // CustomButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, AppRouts.togglePage);
                  //   },
                  //   text: "togglePage",
                  // ),
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
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    shadowColor: Colors.black.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text('💡', style: TextStyle(fontSize: 20)),
                              SizedBox(width: 8),
                              Text(
                                "This Week's Focus",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),
                          const Text(
                            '• Plan your next adventure',
                            style: TextStyle(fontSize: 14, height: 1.5),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '• Call your parents',
                            style: TextStyle(fontSize: 14, height: 1.5),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "• Book that trip you've been thinking about",
                            style: TextStyle(fontSize: 14, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Quick Stats:',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _quickStat(() {}, Icons.terrain, '3/12', 'Advent'),
                      const SizedBox(width: 12),
                      _quickStat(
                        () {
                          Navigator.pushNamed(context, AppRouts.memoryFeedPage);
                        },
                        Icons.family_restroom,
                        '847',
                        'Moments',
                      ),
                      const SizedBox(width: 12),
                      _quickStat(() {}, Icons.calendar_month, '1,247', 'Weeks'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouts.preciousMoments);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Precious Moments'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const GuidanceModal(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Guidance Modal'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const WeeklyReflectionModal(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Weekly Reflection'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => const NotificationsModal(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Notifications'),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouts.trainingLog);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Training Log'),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
            break;
        }

        return RefreshIndicator(onRefresh: _onRefresh, child: contentWidget);
      },
    );
  }
}
// ...existing code...