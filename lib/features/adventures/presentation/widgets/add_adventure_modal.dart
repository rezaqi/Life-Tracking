import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddAdventureModal extends StatefulWidget {
  @override
  _AddAdventureModalState createState() => _AddAdventureModalState();
}

class _AddAdventureModalState extends State<AddAdventureModal> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _selectedCategory = 'Adventure';
  String _targetType = 'By age';
  String _targetValue = '';
  String _motivation = '';
  bool _isMisogi = false;
  File? _selectedImage;

  final List<String> _categories = [
    'Adventure',
    'Learn',
    'Travel',
    'Career',
    'Social',
    'Creative',
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
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
              'Add New Adventure',
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
              Text("What's your next adventure?"),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Adventure name...',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an adventure name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              SizedBox(height: 16),
              Text('Category:'),
              Wrap(
                spacing: 8.0,
                children: _categories.map((category) {
                  return ChoiceChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              Text('Target completion:'),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('By age'),
                      value: 'By age',
                      groupValue: _targetType,
                      onChanged: (value) {
                        setState(() {
                          _targetType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('By date'),
                      value: 'By date',
                      groupValue: _targetType,
                      onChanged: (value) {
                        setState(() {
                          _targetType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              if (_targetType == 'By age')
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'e.g., 35',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _targetValue = value!,
                )
              else
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'e.g., Dec 2024',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => _targetValue = value!,
                ),
              SizedBox(height: 16),
              Text('Why is this important to you?'),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Your motivation...',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _motivation = value!,
              ),
              SizedBox(height: 16),
              Text('📸 Add inspiration photo'),
              Row(
                children: [
                  ElevatedButton.icon(
                    icon: Icon(Icons.camera),
                    label: Text('Camera'),
                    onPressed: () => _pickImage(ImageSource.camera),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton.icon(
                    icon: Icon(Icons.photo),
                    label: Text('Gallery'),
                    onPressed: () => _pickImage(ImageSource.gallery),
                  ),
                ],
              ),
              if (_selectedImage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.file(_selectedImage!, height: 100),
                ),
              SizedBox(height: 16),
              Text('Make this your 2024 Misogi?'),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<bool>(
                      title: Text('Yes'),
                      value: true,
                      groupValue: _isMisogi,
                      onChanged: (value) {
                        setState(() {
                          _isMisogi = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<bool>(
                      title: Text('No'),
                      value: false,
                      groupValue: _isMisogi,
                      onChanged: (value) {
                        setState(() {
                          _isMisogi = value!;
                        });
                      },
                    ),
                  ),
                ],
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
              // TODO: Handle create action, e.g., save to database
              Navigator.of(context).pop();
            }
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}
