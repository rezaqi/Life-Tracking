import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMemoryModal extends StatefulWidget {
  @override
  _AddMemoryModalState createState() => _AddMemoryModalState();
}

class _AddMemoryModalState extends State<AddMemoryModal> {
  final _formKey = GlobalKey<FormState>();
  String _story = '';
  List<String> _selectedPeople = [];
  DateTime? _selectedDate;
  List<String> _tags = [];
  String _shareWith = 'Private';
  File? _selectedMedia;
  bool _isVideo = false;

  final List<String> _peopleOptions = [
    '👨‍👩‍👧‍👦 Family',
    '👫 Friends',
    '💼 Colleagues',
  ];
  final List<String> _defaultTags = ['#adventure', '#family', '#milestone'];
  final List<String> _shareOptions = ['🔒 Private', '👥 Friends', '🌍 All'];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickMedia(ImageSource source, {bool isVideo = false}) async {
    if (isVideo) {
      final pickedFile = await _picker.pickVideo(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedMedia = File(pickedFile.path);
          _isVideo = true;
        });
      }
    } else {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedMedia = File(pickedFile.path);
          _isVideo = false;
        });
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addCustomTag() {
    showDialog(
      context: context,
      builder: (context) {
        String newTag = '';
        return AlertDialog(
          title: Text('Add Custom Tag'),
          content: TextField(
            onChanged: (value) => newTag = value,
            decoration: InputDecoration(hintText: 'Enter tag...'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newTag.isNotEmpty && !newTag.startsWith('#')) {
                  newTag = '#$newTag';
                }
                if (newTag.isNotEmpty && !_tags.contains(newTag)) {
                  setState(() {
                    _tags.add(newTag);
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addCustomPerson() {
    showDialog(
      context: context,
      builder: (context) {
        String newPerson = '';
        return AlertDialog(
          title: Text('Add Person'),
          content: TextField(
            onChanged: (value) => newPerson = value,
            decoration: InputDecoration(hintText: 'Enter person...'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newPerson.isNotEmpty &&
                    !_selectedPeople.contains(newPerson)) {
                  setState(() {
                    _selectedPeople.add(newPerson);
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Text(
              'Capture This Moment',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo/Video area
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _selectedMedia != null
                    ? (_isVideo
                          ? Center(child: Text('Video selected'))
                          : Image.file(_selectedMedia!, fit: BoxFit.cover))
                    : Center(child: Text('📸 Large photo/video area')),
              ),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.camera),
                      label: Text('Camera'),
                      onPressed: () => _pickMedia(ImageSource.camera),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: Icon(Icons.photo),
                      label: Text('Gallery'),
                      onPressed: () => _pickMedia(ImageSource.gallery),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton.icon(
                      icon: Icon(Icons.videocam),
                      label: Text('Video'),
                      onPressed: () =>
                          _pickMedia(ImageSource.gallery, isVideo: true),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('What made this special?'),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Tell the story...',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _story = value ?? '',
              ),
              SizedBox(height: 16),
              Text('Who was there?'),
              Wrap(
                spacing: 8.0,
                children: [
                  ..._peopleOptions.map((person) {
                    return FilterChip(
                      label: Text(person),
                      selected: _selectedPeople.contains(person),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedPeople.add(person);
                          } else {
                            _selectedPeople.remove(person);
                          }
                        });
                      },
                    );
                  }),
                  ActionChip(
                    label: Text('+ Add Person'),
                    onPressed: _addCustomPerson,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('When did this happen?'),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('📅 Today'),
                      value: 'Today',
                      groupValue: _selectedDate == null
                          ? 'Today'
                          : 'Choose Date',
                      onChanged: (value) {
                        setState(() {
                          _selectedDate = null;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('📅 Choose Date'),
                      value: 'Choose Date',
                      groupValue: _selectedDate == null
                          ? 'Today'
                          : 'Choose Date',
                      onChanged: (value) {
                        _selectDate(context);
                      },
                    ),
                  ),
                ],
              ),
              if (_selectedDate != null)
                Text(
                  'Selected: ${_selectedDate!.toLocal().toString().split(' ')[0]}',
                ),
              SizedBox(height: 16),
              Text('Tags:'),
              Wrap(
                spacing: 8.0,
                children: [
                  ..._defaultTags.map((tag) {
                    return FilterChip(
                      label: Text(tag),
                      selected: _tags.contains(tag),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _tags.add(tag);
                          } else {
                            _tags.remove(tag);
                          }
                        });
                      },
                    );
                  }),
                  ActionChip(
                    label: Text('+ Custom Tag'),
                    onPressed: _addCustomTag,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text('Share with:'),
              Wrap(
                spacing: 8.0,
                children: _shareOptions.map((option) {
                  return ChoiceChip(
                    label: Text(option),
                    selected: _shareWith == option,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _shareWith = option;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              // TODO: Save the memory
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Memory saved!')));
              Navigator.of(context).pop();
            }
          },
          child: Text('Save Memory'),
        ),
      ],
    );
  }
}
