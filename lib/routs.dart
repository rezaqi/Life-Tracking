import 'package:flutter/material.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/features/auth/presentation/pages/login_page.dart';
import 'package:life_tracking/features/auth/presentation/pages/signup_page.dart';
import 'package:life_tracking/features/life_celendar/presentation/pages/life_calendar_page.dart';

Map<String, Widget Function(BuildContext)> routs = {
  '/': (_) => const LoginPage(),
  '/signup': (_) => SignUpPage(),
  AppRouts.lifeCalendarPage: (_) => const LifeCalendarPage(),
  // "/": (_) => CategoryProgressBar(
  //   progress: 10,
  //   color: Colors.blue,
  //   category: "category",
  // ),
};
