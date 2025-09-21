import 'package:flutter/material.dart';
import 'package:life_tracking/routs.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Life Tracking',
      theme: ThemeData(primarySwatch: Colors.indigo),
      routes: routs,
    );
  }
}
