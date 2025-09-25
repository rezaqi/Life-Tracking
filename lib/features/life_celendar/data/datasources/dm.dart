import 'dart:io';

import 'package:flutter/material.dart';
import 'package:life_tracking/features/life_celendar/data/models/day_model.dart';

abstract class DmLifeCalender {
  Future<List<String?>> uploadImageToCloudinary(List<File> imageFile);

  Future<void> saveDay(
    BuildContext context,

    List<File> imageFiles,
    String docId,
    String title,
    String des,
    String mood,
    String date,
  );
  Future<DayModel?> getDayMemory(String userId, String date);
}
