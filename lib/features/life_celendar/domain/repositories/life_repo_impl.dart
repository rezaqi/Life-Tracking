// features/life_calendar/data/repositories/life_repository_impl.dart
import 'package:life_tracking/features/life_celendar/data/datasources/local_db.dart';
import 'package:life_tracking/features/life_celendar/data/models/dot_model.dart';
import 'package:life_tracking/features/life_celendar/data/models/milestone_model.dart';

import '../../domain/repositories/life_repository.dart';

class LifeRepositoryImpl implements LifeRepository {
  final LocalDb _db;
  LifeRepositoryImpl(this._db);

  @override
  List<DotModel> generateDotsForYear(int year) {
    final List<DotModel> dots = [];
    final int weeksPerYear = 52; // تقريبياً

    final DateTime startOfYear = DateTime(year, 1, 1);

    for (int w = 0; w < weeksPerYear; w++) {
      dots.add(
        DotModel(
          weekDate: startOfYear.add(Duration(days: w * 7)),
          // يمكنك إضافة بيانات أخرى مثل milestones أو notes
        ),
      );
    }

    return dots;
  }

  @override
  Future<List<DotModel>> getLifeDots(int ageYears) async {
    // Generate 52 dots per year
    final List<DotModel> dots = [];
    final now = DateTime.now();
    final startDate = DateTime(now.year - ageYears, now.month, now.day);
    for (int y = 0; y < ageYears; y++) {
      for (int w = 0; w < 52; w++) {
        final weekDate = startDate.add(Duration(days: (y * 52 + w) * 7));
        dots.add(
          DotModel(
            weekDate: weekDate,
            isPast: weekDate.isBefore(now),
            isPresent: weekDate.isAtSameMomentAs(now),
            isFuture: weekDate.isAfter(now),
          ),
        );
      }
    }
    return dots;
  }

  @override
  Future<void> saveNote(DateTime week, String note) => _db.saveNote(week, note);

  @override
  Future<void> addMilestone(DateTime week, MilestoneModel milestone) =>
      _db.addMilestone(week, milestone);
}
