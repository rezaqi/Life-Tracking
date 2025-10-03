import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/features/app_settings/data/app_settings_service.dart';

class TogglePage extends StatefulWidget {
  const TogglePage({super.key});

  @override
  State<TogglePage> createState() => _TogglePageState();
}

class _TogglePageState extends State<TogglePage> {
  final AppSettingsService _service = AppSettingsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toggle Page')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _service.getSettingsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final data = snapshot.data?.data() as Map<String, dynamic>?;
          final isOn = data?['isOn'] ?? false;

          // If isOn becomes true, navigate to payment page
          if (isOn) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(AppRouts.paymentPage);
            });
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lamp indicator
                Icon(
                  Icons.lightbulb,
                  size: 100,
                  color: isOn ? Colors.green : Colors.grey,
                ),
                const SizedBox(height: 20),
                Text('Is On: $isOn'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await _service.toggleIsOn();
                  },
                  child: const Text('Toggle'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
