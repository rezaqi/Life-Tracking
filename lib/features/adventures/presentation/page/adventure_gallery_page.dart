import 'package:flutter/material.dart';

class AdventureGalleryPage extends StatefulWidget {
  @override
  _AdventureGalleryPageState createState() => _AdventureGalleryPageState();
}

class _AdventureGalleryPageState extends State<AdventureGalleryPage> {
  String _filter = 'All';
  String _sort = 'Deadline';

  final List<String> filters = ['All', 'Active', 'Done'];
  final List<String> sorts = ['Deadline', 'Category'];

  // Sample data for adventures grouped by category
  final Map<String, List<Map<String, dynamic>>> adventuresByCategory = {
    'Misogi Challenge': [
      {
        'title': 'Climb 5 Peaks',
        'status': 'Active',
        'progress': '60%',
        'days': 168,
        'image': 'assets/mountain_photo.png',
      },
    ],
    'Travel Adventures': [
      {
        'title': 'Visit Japan',
        'target': 'By age 35',
        'timeLeft': '7 years left',
        'image': 'assets/japan_photo.png',
      },
      {
        'title': 'Hike Machu Picchu',
        'target': 'By age 40',
        'status': 'Planning phase',
        'image': 'assets/machu_picchu_photo.png',
      },
    ],
    'Learning Goals': [
      {
        'title': 'Learn Spanish',
        'target': 'Conversational',
        'progress': '45 days',
        'highlight': true,
        'image': 'assets/spanish_flag_icon.png',
      },
    ],
  };

  final int completedCount = 12;

  Widget _buildFilterChips() {
    return Row(
      children: filters.map((filter) {
        final bool selected = _filter == filter;
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(filter),
            selected: selected,
            onSelected: (bool selected) {
              setState(() {
                _filter = filter;
              });
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSortChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: sorts.map((sort) {
          final bool selected = _sort == sort;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(sort),
              selected: selected,
              onSelected: (bool selected) {
                setState(() {
                  _sort = sort;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAdventureCard(Map<String, dynamic> adventure) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
              child: Icon(Icons.image, size: 40),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    adventure['title'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  if (adventure.containsKey('status'))
                    Text('Status: ${adventure['status']}'),
                  if (adventure.containsKey('progress'))
                    Text('Progress: ${adventure['progress']}'),
                  if (adventure.containsKey('days'))
                    Text('Days: ${adventure['days']}'),
                  if (adventure.containsKey('target'))
                    Text('Target: ${adventure['target']}'),
                  if (adventure.containsKey('timeLeft'))
                    Text('${adventure['timeLeft']}'),
                  if (adventure.containsKey('highlight') &&
                      adventure['highlight'])
                    Row(
                      children: [
                        Text('⚡', style: TextStyle(fontSize: 16)),
                        SizedBox(width: 4),
                        Text('Highlight'),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCategorySection(
    String category,
    List<Map<String, dynamic>> adventures,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          category,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      ...adventures.map(_buildAdventureCard).toList(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('All Adventures'),
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            onPressed: () {
              // Action for the lightning icon
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters and Sorts
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filter:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                _buildFilterChips(),
                SizedBox(height: 8),
                Text('Sort:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                _buildSortChips(),
              ],
            ),
            SizedBox(height: 12),

            // Adventures list
            Expanded(
              child: ListView(
                children: [
                  ...adventuresByCategory.entries
                      .expand(
                        (entry) =>
                            _buildCategorySection(entry.key, entry.value),
                      )
                      .toList(),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 8),
                  Text(
                    '✅ Completed ($completedCount)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // Show all completed action
                    },
                    child: Text('Show All Completed'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
