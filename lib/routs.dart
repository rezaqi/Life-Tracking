import 'package:flutter/material.dart';
import 'package:life_tracking/check_root.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/features/adventures/presentation/page/adventure_gallery_page.dart';
import 'package:life_tracking/features/app_settings/presentation/pages/payment_page.dart';
import 'package:life_tracking/features/app_settings/presentation/pages/toggle_page.dart';
import 'package:life_tracking/features/auth/presentation/pages/login_page.dart';
import 'package:life_tracking/features/dashboard/dashboard.dart';
import 'package:life_tracking/features/life_celendar/presentation/pages/life_calendar_page.dart';
import 'package:life_tracking/features/life_celendar/presentation/pages/life_event_planning_page.dart';
import 'package:life_tracking/features/life_celendar/presentation/widgets/life_progress_page.dart';
import 'package:life_tracking/features/life_tracker/presentation/page/precious_moments_page.dart';
import 'package:life_tracking/features/moments/presentation/page/follow_events.dart';
import 'package:life_tracking/features/moments/presentation/page/memory_feed_page.dart';
import 'package:life_tracking/features/onboarding/presentation/page/intro_screen.dart';
import 'package:life_tracking/features/profile/presentation/page/privacy_settings_page.dart';
import 'package:life_tracking/features/profile/presentation/page/settings_page.dart';
import 'package:life_tracking/features/relationships/domain/model/relationship.dart';
import 'package:life_tracking/features/relationships/presentation/page/relationship_detail_page.dart';
import 'package:life_tracking/features/social_hub/presentation/page/photo_memory_detail_page.dart';
import 'package:life_tracking/features/social_hub/presentation/page/smart_suggestions_page.dart';
import 'package:life_tracking/features/tabs/presentaion/page/tabs.dart';
import 'package:life_tracking/features/training_log/presentation/page/training_log_page.dart';

Map<String, Widget Function(BuildContext)> routs = {
  '/': (_) => RootScreen(),
  AppRouts.introScreen: (_) => IntroScreen(),
  AppRouts.login: (_) => const LoginPage(),
  AppRouts.dashboardScreen: (_) => ClientInfoPage(),
  AppRouts.tabsScreen: (_) => TabsScreen(),

  AppRouts.lifeProgressPage: (_) => LifeProgressWidget(),
  AppRouts.lifeCalendarPage: (_) => const LifeCalendarPage(),

  AppRouts.lifeEventPlanningPage: (_) => LifeEventPlanningPage(),

  AppRouts.followEvents: (_) => const FollowEvents(),
  AppRouts.privacySettings: (_) => PrivacySettingsPage(),
  AppRouts.preciousMoments: (_) => const PreciousMomentsPage(),
  AppRouts.memoryFeedPage: (_) => const MemoryFeedPage(),
  AppRouts.settings: (_) => SettingsPage(),
  AppRouts.adventureGallery: (_) => AdventureGalleryPage(),

  AppRouts.relationshipDetail: (context) => RelationshipDetailPage(
    relationship: Relationship(
      name: "Barbara Thompson",
      age: 67,
      relation: "Mother",
      distance: "2 hours",
      averageLifespanYears: 67,
      recentMemoriesCount: 15,
      lastCallDaysAgo: 5,
      lastVisitWeeksAgo: 3,
      averageContactDays: 4,
      callGoalWeekly: 1,
      visitGoalMonthly: 1,
      visitGoalBehindBy: 1,
      recipesLearned: 3,
      recipesTotal: 12,
      qualityTimeIdeas: [
        "Cook her lasagna recipe",
        "Look through old photo albums",
        "Plan weekend getaway",
        "Record family stories",
      ],
    ),
  ),
  AppRouts.smartSuggestions: (_) => SmartSuggestionsPage(),
  AppRouts.photoMemoryDetail: (context) => PhotoMemoryDetailPage(
    post: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
  ),
  AppRouts.trainingLog: (_) => TrainingLogPage(),
  AppRouts.togglePage: (_) => const TogglePage(),
  AppRouts.paymentPage: (_) => const PaymentPage(),
};
