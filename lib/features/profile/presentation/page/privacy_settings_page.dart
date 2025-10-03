import 'package:flutter/material.dart';

enum Visibility { friends, public, private }

class PrivacySettingsPage extends StatefulWidget {
  @override
  _PrivacySettingsPageState createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  Visibility _profileVisibility = Visibility.friends;
  Visibility _adventuresVisibility = Visibility.public;
  Visibility _momentsVisibility = Visibility.friends;
  Visibility _statsVisibility = Visibility.private;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Settings'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Control who can see your content',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildSettingSection(
              'Profile Visibility',
              'Who can view your profile information',
              _profileVisibility,
              (value) => setState(() => _profileVisibility = value),
            ),
            _buildSettingSection(
              'Adventures Visibility',
              'Who can see your adventures',
              _adventuresVisibility,
              (value) => setState(() => _adventuresVisibility = value),
            ),
            _buildSettingSection(
              'Moments Visibility',
              'Who can view your moments',
              _momentsVisibility,
              (value) => setState(() => _momentsVisibility = value),
            ),
            _buildSettingSection(
              'Life Stats Visibility',
              'Who can see your life statistics',
              _statsVisibility,
              (value) => setState(() => _statsVisibility = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSection(
    String title,
    String subtitle,
    Visibility currentValue,
    ValueChanged<Visibility> onChanged,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(subtitle, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 12),
            SegmentedButton<Visibility>(
              segments: const [
                ButtonSegment(
                  value: Visibility.friends,
                  label: Text('Friends'),
                ),
                ButtonSegment(value: Visibility.public, label: Text('Public')),
                ButtonSegment(
                  value: Visibility.private,
                  label: Text('Private'),
                ),
              ],
              selected: {currentValue},
              onSelectionChanged: (Set<Visibility> selected) {
                onChanged(selected.first);
              },
            ),
          ],
        ),
      ),
    );
  }
}
