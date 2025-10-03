import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool weeklyReflections = true;
  bool adventureReminders = true;
  bool familyNudges = true;
  bool milestoneAlerts = true;
  bool friendActivity = false;

  String lifeExpectancy = "85";
  String appVersion = "1.0.0";

  @override
  void initState() {
    super.initState();
    // App version is hardcoded as per ASCII art
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _buildSection('👤 Account', [
            _buildListTile('Profile Information', () {}),
            _buildListTile('Change Password', () {}),
            _buildListTile('Connected Accounts', () {}),
          ]),
          _buildSection('🔔 Notifications', [
            _buildSwitchTile('Weekly Reflections', weeklyReflections, (value) {
              setState(() => weeklyReflections = value);
            }),
            _buildSwitchTile('Adventure Reminders', adventureReminders, (
              value,
            ) {
              setState(() => adventureReminders = value);
            }),
            _buildSwitchTile('Family Nudges', familyNudges, (value) {
              setState(() => familyNudges = value);
            }),
            _buildSwitchTile('Milestone Alerts', milestoneAlerts, (value) {
              setState(() => milestoneAlerts = value);
            }),
            _buildSwitchTile('Friend Activity', friendActivity, (value) {
              setState(() => friendActivity = value);
            }),
          ]),
          _buildSection('🎨 Personalization', [
            _buildListTile('Dashboard Layout', () {}),
            _buildListTile('Calendar View Preference', () {}),
            _buildListTile('Color Theme', () {}),
            _buildEditableTile('Life Expectancy', lifeExpectancy, (value) {
              setState(() => lifeExpectancy = value);
            }),
          ]),
          _buildSection('📊 Data & Privacy', [
            _buildListTile('Export My Data', () {}),
            _buildListTile('Delete Account', () {}),
            _buildListTile('Privacy Policy', () {}),
            _buildListTile('Terms of Service', () {}),
          ]),
          _buildSection('🔗 Social', [
            _buildListTile('Find Friends', () {}),
            _buildListTile('Share Settings', () {}),
            _buildListTile('Block List', () {}),
          ]),
          _buildSection('ℹ️ Support', [
            _buildListTile('Help Center', () {}),
            _buildListTile('Send Feedback', () {}),
            _buildListTile('Report a Bug', () {}),
            _buildAppVersionTile(),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...children,
        Divider(),
      ],
    );
  }

  Widget _buildListTile(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildEditableTile(
    String title,
    String value,
    ValueChanged<String> onChanged,
  ) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('[Edit: $value]'),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final result = await showDialog<String>(
                context: context,
                builder: (context) => _EditDialog(initialValue: value),
              );
              if (result != null) {
                onChanged(result);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppVersionTile() {
    return ListTile(title: Text('App Version'), trailing: Text(appVersion));
  }
}

class _EditDialog extends StatefulWidget {
  final String initialValue;

  const _EditDialog({required this.initialValue});

  @override
  __EditDialogState createState() => __EditDialogState();
}

class __EditDialogState extends State<_EditDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Life Expectancy'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(hintText: 'Enter age'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          child: Text('Save'),
        ),
      ],
    );
  }
}
