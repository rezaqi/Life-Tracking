import 'package:flutter/material.dart';

class LifePlanningPage extends StatefulWidget {
  const LifePlanningPage({super.key});

  @override
  State<LifePlanningPage> createState() => _LifePlanningPageState();
}

class _LifePlanningPageState extends State<LifePlanningPage> {
  double lifeExpectancy = 85.0;
  final Set<String> healthGoals = {};
  final Set<String> majorLifeEvents = {};

  void _toggleHealthGoal(String goal) {
    setState(() {
      if (healthGoals.contains(goal)) {
        healthGoals.remove(goal);
      } else {
        healthGoals.add(goal);
      }
    });
  }

  void _toggleMajorEvent(String event) {
    setState(() {
      if (majorLifeEvents.contains(event)) {
        majorLifeEvents.remove(event);
      } else {
        majorLifeEvents.add(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Life Planning'),
        actions: const [Icon(Icons.person)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('⏰ Life Expectancy: '),
                Text('${lifeExpectancy.round()} years'),
              ],
            ),
            Slider(
              value: lifeExpectancy,
              min: 70,
              max: 100,
              divisions: 30,
              onChanged: (value) {
                setState(() {
                  lifeExpectancy = value;
                });
              },
            ),
            const Row(
              children: [
                Text('70'),
                Spacer(),
                Text('85'),
                Spacer(),
                Text('100'),
              ],
            ),
            const SizedBox(height: 20),
            const Text('🏥 Health Goals:'),
            CheckboxListTile(
              title: const Text('Annual Checkups'),
              value: healthGoals.contains('Annual Checkups'),
              onChanged: (value) => _toggleHealthGoal('Annual Checkups'),
            ),
            CheckboxListTile(
              title: const Text('Exercise'),
              value: healthGoals.contains('Exercise'),
              onChanged: (value) => _toggleHealthGoal('Exercise'),
            ),
            const SizedBox(height: 20),
            const Text('🎯 Major Life Events:'),
            CheckboxListTile(
              title: const Text('Retirement Planning'),
              value: majorLifeEvents.contains('Retirement Planning'),
              onChanged: (value) => _toggleMajorEvent('Retirement Planning'),
            ),
            CheckboxListTile(
              title: const Text('Legacy Planning'),
              value: majorLifeEvents.contains('Legacy Planning'),
              onChanged: (value) => _toggleMajorEvent('Legacy Planning'),
            ),
          ],
        ),
      ),
    );
  }
}
