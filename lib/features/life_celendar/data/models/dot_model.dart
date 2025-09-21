// features/life_calendar/data/models/dot_model.dart
import 'milestone_model.dart';

class DotModel {
  final DateTime weekDate;
  final bool isPast;
  final bool isPresent;
  final bool isFuture;
  final String? note;
  final List<MilestoneModel> milestones;

  DotModel({
    required this.weekDate,
    this.isPast = false,
    this.isPresent = false,
    this.isFuture = false,
    this.note,
    this.milestones = const [],
  });

  DotModel copyWith({
    final DateTime? weekDate,
    final bool? isPast,
    final bool? isPresent,
    final bool? isFuture,
    final String? note,
    final List<MilestoneModel>? milestones,
  }) {
    return DotModel(
      weekDate: weekDate ?? this.weekDate,
      isPast: isPast ?? this.isPast,
      isPresent: isPresent ?? this.isPresent,
      isFuture: isFuture ?? this.isFuture,
      note: note ?? this.note,
      milestones: milestones ?? this.milestones,
    );
  }
}
