// features/life_calendar/data/datasources/local_db.dart
import '../models/dot_model.dart';
import '../models/milestone_model.dart';

class LocalDb {
  final Map<DateTime, DotModel> _dots = {};

  Future<void> saveNote(DateTime week, String note) async {
    if (_dots.containsKey(week)) {
      _dots[week] = _dots[week]!.copyWith(note: note);
    } else {
      _dots[week] = DotModel(weekDate: week, note: note);
    }
  }

  Future<void> addMilestone(DateTime week, MilestoneModel milestone) async {
    if (_dots.containsKey(week)) {
      final current = _dots[week]!;
      _dots[week] = current.copyWith(
        milestones: [...current.milestones, milestone],
      );
    } else {
      _dots[week] = DotModel(weekDate: week, milestones: [milestone]);
    }
  }

  List<DotModel> getAllDots() => _dots.values.toList();
}
