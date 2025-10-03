import 'package:flutter/material.dart';

class PhotoMemoryDetailPage extends StatelessWidget {
  final Map<String, dynamic> post;

  const PhotoMemoryDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [IconButton(icon: Icon(Icons.more_vert), onPressed: () {})],
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full-screen photo
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              child: Image.network(
                post['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(Icons.photo, size: 100, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            // Details section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    post['title'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Date and location
                  Row(
                    children: [
                      Text(
                        post['time'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(' • ', style: TextStyle(color: Colors.grey[600])),
                      Text(
                        post['location'] ?? 'Unknown Location',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Description
                  Text(post['description'], style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  // With
                  if (post['with'] != null)
                    Row(
                      children: [
                        Icon(Icons.people, color: Colors.grey[600]),
                        SizedBox(width: 8),
                        Text(
                          'With: ${post['with']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  SizedBox(height: 8),
                  // Tags
                  if (post['tags'] != null)
                    Row(
                      children: [
                        Icon(Icons.tag, color: Colors.grey[600]),
                        SizedBox(width: 8),
                        Text(
                          'Tags: ${post['tags'].join(', ')}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  SizedBox(height: 8),
                  // Location again?
                  if (post['location'] != null)
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey[600]),
                        SizedBox(width: 8),
                        Text(
                          post['location'],
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  SizedBox(height: 16),
                  // Likes and comments
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.red),
                      SizedBox(width: 4),
                      Text('${post['likes']} likes'),
                      SizedBox(width: 16),
                      Icon(Icons.comment, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text('${post['comments']} comments'),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Sample comment
                  if (post['sampleComment'] != null)
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['sampleComment']['user'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(post['sampleComment']['text']),
                        ],
                      ),
                    ),
                  SizedBox(height: 16),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.comment),
                          label: Text('Add Comment'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.share),
                          label: Text('Share'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                          label: Text('Edit'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            foregroundColor: Colors.black,
                          ),
                        ),
                      ),
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
}
