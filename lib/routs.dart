import 'package:flutter/material.dart';
import 'package:life_tracking/check_root.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/features/auth/presentation/pages/login_page.dart';
import 'package:life_tracking/features/dashboard/dashboard.dart';
import 'package:life_tracking/features/life_celendar/presentation/pages/life_calendar_page.dart';
import 'package:life_tracking/features/life_celendar/presentation/widgets/life_progress_page.dart';
import 'package:life_tracking/features/moments/presentation/page/follow_events.dart';
import 'package:life_tracking/features/onboarding/presentation/page/intro_screen.dart';
import 'package:life_tracking/features/tabs/presentaion/page/tabs.dart';

Map<String, Widget Function(BuildContext)> routs = {
  '/': (_) => RootScreen(),
  AppRouts.introScreen: (_) => IntroScreen(),
  AppRouts.dashboardScreen: (_) => ClientInfoPage(),
  AppRouts.tabsScreen: (_) => TabsScreen(),

  AppRouts.lifeProgressPage: (_) => LifeProgressWidget(),
  AppRouts.login: (_) => const LoginPage(),
  //  AppRouts.signup: (_) => SignUpPage(),
  AppRouts.lifeCalendarPage: (_) => const LifeCalendarPage(),

  AppRouts.followEvents: (_) => const FollowEvents(),
};
