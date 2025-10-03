import 'package:flutter/material.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  String selectedPostType = '🏆 Achievement';
  String selectedAdventure = '🏔️ Mount Washington Training';
  String selectedShareWith = '👥 Friends';
  bool shareInstagram = true;
  bool shareStrava = true;
  bool shareFacebook = false;
  bool shareTwitter = false;

  final TextEditingController _storyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Share Your Progress',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Handle post
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Text(
                  'Post',
                  style: TextStyle(color: Colors.blue[600], fontSize: 16),
                ),
                SizedBox(width: 4),
                Icon(Icons.send, color: Colors.blue[600], size: 18),
              ],
            ),
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
              // Photo/Video Area
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 48, color: Colors.grey[500]),
                      SizedBox(height: 8),
                      Text(
                        'Tap to add photo or video',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.camera, color: Colors.white),
                    label: Text(
                      'Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.photo_library, color: Colors.white),
                    label: Text(
                      'Gallery',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.explore, color: Colors.white),
                    label: Text(
                      'Adventure',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'What did you accomplish?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _storyController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Share your story...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Post Type:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children:
                    [
                          '🏆 Achievement',
                          '📈 Progress',
                          '👥 Milestone',
                          '💡 Inspiration',
                        ]
                        .map(
                          (type) => ChoiceChip(
                            label: Text(type),
                            selected: selectedPostType == type,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() => selectedPostType = type);
                              }
                            },
                            selectedColor: Colors.blue[100],
                          ),
                        )
                        .toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Link to Adventure:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedAdventure,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items:
                    [
                          '🏔️ Mount Washington Training',
                          '📚 Learn Spanish',
                          '+ Other',
                        ]
                        .map(
                          (adventure) => DropdownMenuItem(
                            value: adventure,
                            child: Text(adventure),
                          ),
                        )
                        .toList(),
                onChanged: (value) {
                  setState(() => selectedAdventure = value!);
                },
              ),
              SizedBox(height: 20),
              Text(
                'Share with:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['👥 Friends', '🌍 Public', '🔒 Private']
                    .map(
                      (option) => ChoiceChip(
                        label: Text(option),
                        selected: selectedShareWith == option,
                        onSelected: (selected) {
                          if (selected) {
                            setState(() => selectedShareWith = option);
                          }
                        },
                        selectedColor: Colors.blue[100],
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 20),
              Text(
                'Also share to:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  CheckboxListTile(
                    title: Text('Instagram'),
                    value: shareInstagram,
                    onChanged: (value) =>
                        setState(() => shareInstagram = value!),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text('Strava'),
                    value: shareStrava,
                    onChanged: (value) => setState(() => shareStrava = value!),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text('Facebook'),
                    value: shareFacebook,
                    onChanged: (value) =>
                        setState(() => shareFacebook = value!),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  CheckboxListTile(
                    title: Text('Twitter'),
                    value: shareTwitter,
                    onChanged: (value) => setState(() => shareTwitter = value!),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancel'),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle post
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Post'),
                          SizedBox(width: 8),
                          Icon(Icons.send),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
