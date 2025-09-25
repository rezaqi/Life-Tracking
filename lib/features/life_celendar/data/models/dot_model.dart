import 'package:flutter/material.dart';
import 'package:life_tracking/features/life_celendar/data/models/milestone_model.dart';

class DotModel {
  final DateTime weekDate;
  final bool isPast;
  final bool isPresent;
  final bool isFuture;
  final String? note;
  final List<MilestoneModel> milestones;
  final String? imageUrl; // أضفنا رابط الصورة

  DotModel({
    required this.weekDate,
    this.isPast = false,
    this.isPresent = false,
    this.isFuture = false,
    this.note,
    this.milestones = const [],
    this.imageUrl,
  });

  DotModel copyWith({
    final DateTime? weekDate,
    final bool? isPast,
    final bool? isPresent,
    final bool? isFuture,
    final String? note,
    final List<MilestoneModel>? milestones,
    final String? imageUrl,
  }) {
    return DotModel(
      weekDate: weekDate ?? this.weekDate,
      isPast: isPast ?? this.isPast,
      isPresent: isPresent ?? this.isPresent,
      isFuture: isFuture ?? this.isFuture,
      note: note ?? this.note,
      milestones: milestones ?? this.milestones,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  // هنا التعديل
  factory DotModel.fromMap(Map<String, dynamic> map) {
    final date = DateTime.parse(map['weekDate']);
    final today = DateTime.now();

    final isToday =
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    final isPast = date.isBefore(today) && !isToday;
    final isFuture = date.isAfter(today) && !isToday;

    return DotModel(
      weekDate: date,
      isPast: isPast,
      isPresent: isToday,
      isFuture: isFuture,
      note: map['note'],
      milestones: [], // تكمّلها بعدين
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weekDate': weekDate.toIso8601String(),
      'note': note,
      'imageUrl': imageUrl,
      // مش محتاج تخزن isPast/isFuture/isPresent لأننا بنحسبها دايمًا
    };
  }

  Color get color {
    if (isPresent) return Colors.amber;
    if (isPast) return Colors.grey[700]!;
    if (isFuture) return Colors.blue;
    return Colors.grey[400]!;
  }
}
