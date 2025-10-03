import 'package:flutter/material.dart';

class LeaderboardsPage extends StatefulWidget {
  @override
  _LeaderboardsPageState createState() => _LeaderboardsPageState();
}

class _LeaderboardsPageState extends State<LeaderboardsPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Most Adventures Completed',
      'leaderboard': [
        {'name': 'Sarah Chen', 'value': 7, 'isUser': false},
        {'name': 'You (Alex)', 'value': 5, 'isUser': true},
        {'name': 'Mike Rodriguez', 'value': 4, 'isUser': false},
        {'name': 'Lisa Park', 'value': 3, 'isUser': false},
        {'name': 'David Kim', 'value': 2, 'isUser': false},
      ],
    },
    {
      'title': 'Training Days This Week',
      'leaderboard': [
        {'name': 'You (Alex)', 'value': 6, 'isUser': true},
        {'name': 'Mike Rodriguez', 'value': 5, 'isUser': false},
        {'name': 'Sarah Chen', 'value': 4, 'isUser': false},
        {'name': 'Lisa Park', 'value': 3, 'isUser': false},
        {'name': 'David Kim', 'value': 1, 'isUser': false},
      ],
    },
    {
      'title': 'Precious Moments Shared',
      'leaderboard': [
        {'name': 'Mike Rodriguez', 'value': 12, 'isUser': false},
        {'name': 'Lisa Park', 'value': 9, 'isUser': false},
        {'name': 'You (Alex)', 'value': 8, 'isUser': true},
        {'name': 'Sarah Chen', 'value': 6, 'isUser': false},
        {'name': 'David Kim', 'value': 4, 'isUser': false},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animations = List.generate(
      categories.length,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(index * 0.2, 1.0, curve: Curves.easeOut),
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Friend Leaderboards',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey[50]!],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text('🏆', style: TextStyle(fontSize: 24)),
                    SizedBox(width: 8),
                    Text(
                      'This Month\'s Champions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[800],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ...List.generate(categories.length, (index) {
                return AnimatedBuilder(
                  animation: _animations[index],
                  builder: (context, child) {
                    return Opacity(
                      opacity: _animations[index].value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - _animations[index].value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categories[index]['title'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: List.generate(
                              categories[index]['leaderboard'].length,
                              (rank) {
                                final item =
                                    categories[index]['leaderboard'][rank];
                                final isTop3 = rank < 3;
                                final medal = isTop3
                                    ? ['🥇', '🥈', '🥉'][rank]
                                    : '${rank + 1}.';
                                return Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: item['isUser']
                                        ? Colors.blue[50]
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        medal,
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(width: 12),
                                      CircleAvatar(
                                        backgroundColor: item['isUser']
                                            ? Colors.blue[100]
                                            : Colors.green[100],
                                        child: Icon(
                                          Icons.person,
                                          color: item['isUser']
                                              ? Colors.blue[600]
                                              : Colors.green[600],
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          item['name'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: item['isUser']
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: item['isUser']
                                                ? Colors.blue[800]
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${item['value']}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              }),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'View All Categories',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
