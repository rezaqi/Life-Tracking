import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:life_tracking/core/class/faiiur.dart';
import 'package:life_tracking/features/life_celendar/data/models/day_model.dart';
import 'package:life_tracking/features/life_celendar/domain/repositories/life_repository.dart';

@injectable
class UseCaseLifeCalender {
  final LifeRepository repo;
  UseCaseLifeCalender(this.repo);
  Future<Either<Failure, List<String?>>> call(List<File> imageFile) =>
      repo.uploadImageToCloudinary(imageFile);
  Future<void> callSaveDay(
    BuildContext context,

    List<File> imageFiles,
    String docId,
    String title,
    String des,
    String mood,
    String date,
  ) => repo.saveDay(context, imageFiles, docId, title, des, mood, date);

  Future<DayModel?> callGetDayMemory(String userId, String date) =>
      repo.getDayMemory(userId, date);
}
