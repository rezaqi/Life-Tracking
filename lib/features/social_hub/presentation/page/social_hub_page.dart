import 'package:flutter/material.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/features/social_hub/presentation/page/comments_page.dart';
import 'package:life_tracking/features/social_hub/presentation/page/create_post_page.dart';
import 'package:life_tracking/features/social_hub/presentation/page/friends_challenges_page.dart';
import 'package:life_tracking/features/social_hub/presentation/page/leaderboards_page.dart';

class SocialHubPage extends StatefulWidget {
  @override
  _SocialHubPageState createState() => _SocialHubPageState();
}

class _SocialHubPageState extends State<SocialHubPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  final List<Map<String, dynamic>> posts = [
    {
      'user': 'Alex Thompson',
      'time': '2 hours ago',
      'image':
          'https://via.placeholder.com/600x400/FF6B6B/FFFFFF?text=Training+Photo',
      'title': '🏔️ Mount Washington Prep',
      'description': '"5 miles, 1,200ft elevation Beautiful sunrise views! 💪"',
      'likes': 12,
      'comments': 3,
      'location': 'Mount Washington',
      'tags': ['#hiking', '#fitness'],
      'with': null,
      'sampleComment': null,
    },
    {
      'user': 'Sarah Chen',
      'time': '1 day ago',
      'image':
          'https://via.placeholder.com/600x400/4ECDC4/FFFFFF?text=Adventure+Photo',
      'title': '✅ Completed: Learn Pottery',
      'description':
          '"Finally finished my first ceramic bowl! 8 weeks of classes paid off 🏺"',
      'likes': 24,
      'comments': 8,
      'location': 'Art Studio',
      'tags': ['#art', '#achievement'],
      'with': null,
      'sampleComment': null,
    },
    {
      'user': 'Mike Rodriguez',
      'time': 'Yesterday',
      'image':
          'https://via.placeholder.com/600x400/45B7D1/FFFFFF?text=Soccer+Field',
      'title': '📸 Emma\'s First Goal',
      'description':
          '"She scored her first goal! The joy on her face was everything. These are the moments that make all the early morning practices worth it. So proud! 🥅⚽"',
      'likes': 12,
      'comments': 3,
      'location': 'Riverside Soccer Complex',
      'tags': ['#milestone', '#soccer'],
      'with': 'Emma Thompson',
      'sampleComment': {
        'user': 'Sarah',
        'text': 'I can see the pride in your eyes too! ❤️',
      },
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
      posts.length,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => CreatePostPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[600],
      ),
      appBar: AppBar(
        title: Text(
          'Social Feed',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, AppRouts.relationshipDetail);
            },
          ),
          IconButton(
            icon: Icon(Icons.lightbulb, color: Colors.black),
            tooltip: 'Smart Suggestions',
            onPressed: () {
              Navigator.pushNamed(context, AppRouts.smartSuggestions);
            },
          ),
        ],
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
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text('🔥', style: TextStyle(fontSize: 24)),
                    SizedBox(width: 8),
                    Text(
                      'This Week\'s Achievements',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[800],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FriendsChallengesPage(),
                          ),
                        );
                      },
                      icon: Icon(Icons.group, color: Colors.white),
                      label: Text(
                        'Friends\' Challenges',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LeaderboardsPage()),
                        );
                      },
                      icon: Icon(Icons.leaderboard, color: Colors.white),
                      label: Text(
                        'Leaderboards',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow[600],
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ...List.generate(posts.length, (index) {
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRouts.photoMemoryDetail,
                        arguments: posts[index],
                      );
                    },
                    child: Card(
                      elevation: 8,
                      margin: EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.blue[100],
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.blue[600],
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    posts[index]['user'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  posts[index]['time'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 180,
                                width: double.infinity,
                                color:
                                    Colors.primaries[index %
                                        Colors.primaries.length][200],
                                child: Center(
                                  child: Text(
                                    posts[index]['image']
                                        .split('?text=')[1]
                                        .replaceAll('+', ' '),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              posts[index]['title'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              posts[index]['description'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.local_fire_department,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {},
                                ),
                                Text(
                                  '${posts[index]['likes']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 16),
                                IconButton(
                                  icon: Icon(Icons.chat_bubble_outline),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CommentsPage(
                                          postIndex: index,
                                          postTitle: posts[index]['title'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  '${posts[index]['comments']}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.share, size: 18),
                                  label: Text('Share'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
                    'Load More Posts',
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
