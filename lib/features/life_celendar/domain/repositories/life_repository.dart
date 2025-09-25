// features/life_calendar/domain/repositories/life_repository.dart
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:life_tracking/core/class/faiiur.dart';
import 'package:life_tracking/features/life_celendar/data/models/day_model.dart';

import '../../data/models/dot_model.dart';
import '../../data/models/milestone_model.dart';

abstract class LifeRepository {
  List<DotModel> generateDotsForYear(int year);
  Future<List<DotModel>> getLifeDots(int ageYears);
  Future<void> saveNote(DateTime week, String note);
  Future<void> addMilestone(DateTime week, MilestoneModel milestone);
  Future<Either<Failure, List<String?>>> uploadImageToCloudinary(
    List<File> imageFile,
  );
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
