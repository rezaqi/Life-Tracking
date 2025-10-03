import 'package:flutter/material.dart';
import 'package:life_tracking/features/app_settings/data/app_settings_service.dart';
import 'package:life_tracking/features/app_settings/presentation/pages/payment_page.dart';
import 'package:life_tracking/features/auth/presentation/pages/login_page.dart';
import 'package:life_tracking/features/onboarding/presentation/page/intro_screen.dart';
import 'package:life_tracking/features/tabs/presentaion/page/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  Widget? _startPage;

  @override
  void initState() {
    super.initState();
    _decideStartPage();
  }

  Future<void> _decideStartPage() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingSeen = prefs.getBool('onboarding_seen') ?? false;
    print(onboardingSeen);
    Widget tempPage;
    if (!onboardingSeen) {
      tempPage = IntroScreen();
    } else {
      final userId = prefs.getString('id');
      if (userId != null && userId.isNotEmpty) {
        tempPage = TabsScreen();
      } else {
        tempPage = const LoginPage();
      }
    }

    // Check isOn
    final service = AppSettingsService();
    final isOn = await service.getIsOn();
    if (isOn) {
      _startPage = const PaymentPage();
    } else {
      _startPage = tempPage;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_startPage == null) {
      // لسه بيشيك
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return _startPage!;
  }
}
