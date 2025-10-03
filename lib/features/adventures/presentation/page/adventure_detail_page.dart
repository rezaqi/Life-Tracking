import 'package:flutter/material.dart';

class AdventureDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Climb 5 Peaks'),
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
        //  backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: Center(child: Text('🏔️ [Hero Image of Mountains]')),
            ),
            SizedBox(height: 16),

            // Title and dates
            Text(
              '2024 Misogi Challenge',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Started: Jan 1, 2024'),
            Text('Target: Dec 31, 2024'),
            SizedBox(height: 16),

            // Progress
            Text(
              'Progress: 60% Complete',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 16),

            // Peaks Conquered
            Text(
              'Peaks Conquered:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text('Mount Monadnock (Mar 15)'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text('Mount Katahdin (May 22)'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle, color: Colors.green),
                  title: Text('Mount Elbert (Jul 4)'),
                ),
                ListTile(
                  leading: Icon(Icons.radio_button_unchecked),
                  title: Text('Mount Washington (Planned)'),
                ),
                ListTile(
                  leading: Icon(Icons.radio_button_unchecked),
                  title: Text('Mount Rainier (Planned)'),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Training Log
            Text(
              'Training Log:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('• 127 miles hiked this year'),
            Text('• 45 training days completed'),
            Text('• 12,450 ft elevation gained'),
            SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Log Training'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Add Photo'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Share Progress'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('View Gallery'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Why This Matters
            Text(
              'Why This Matters:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '"Push my limits and prove to myself that I can do hard things. Each peak represents overcoming a fear or challenge."',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
