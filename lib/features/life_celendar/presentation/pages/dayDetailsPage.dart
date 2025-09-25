import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/features/life_celendar/presentation/bloc/life_bloc.dart';
import 'package:life_tracking/features/life_celendar/presentation/bloc/life_event.dart';
import 'package:life_tracking/features/life_celendar/presentation/bloc/life_state.dart';

class DayDetailsPage extends StatefulWidget {
  final DateTime date;
  final String userId;
  final LifeBloc bloc;
  final LifeState state;

  const DayDetailsPage({
    super.key,
    required this.date,
    required this.userId,
    required this.bloc,
    required this.state,
  });

  @override
  State<DayDetailsPage> createState() => _DayDetailsPageState();
}

class _DayDetailsPageState extends State<DayDetailsPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  // final List<File> _images = [];
  // String? _mood;
  // bool _loading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      widget.bloc.add(OnAddImages(picked.map((e) => File(e.path)).toList()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final moods = ["Bad", "Normal", "Good", "Very Good"];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Day Details ${widget.date.day}/${widget.date.month}/${widget.date.year}",
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              widget.bloc.add(OnSaveDay(context));
            },
          ),
        ],
      ),
      body: BlocConsumer<LifeBloc, LifeState>(
        listener: (context, state) {
          if (state.requestStateSaveDay == RequestState.loading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Day saved successfully ✅")),
            );
            Navigator.pop(context);
          }
          if (state.requestStateSaveDay == RequestState.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to save day ❌")),
            );
          }
        },
        builder: (context, state) {
          if (state.requestStateSaveDay == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.hasMemory) {
            // 👇 UI لعرض الذكرى القديمة
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(width: 40, height: 40, color: Colors.red),
                  Text(
                    state.title ?? "",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Mood: ${state.mood ?? ""}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(state.des ?? "", style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: state.imagesLinksUploaded!.map((url) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          url!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  onChanged: (val) => widget.bloc.add(OnChangeTitle(val)),

                  decoration: const InputDecoration(
                    labelText: "Day Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: state.mood,
                  items: moods
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (val) => widget.bloc.add(OnChangeMood(val)),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  onChanged: (val) => widget.bloc.add(OnChangeDescription(val)),

                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "Day Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...state.imageFiles.map(
                      (file) => Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              file,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () => widget.bloc.add(OnRemoveImage(file)),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
