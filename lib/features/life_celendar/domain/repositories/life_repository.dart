// features/life_calendar/domain/repositories/life_repository.dart
import '../../data/models/dot_model.dart';
import '../../data/models/milestone_model.dart';

abstract class LifeRepository {
  List<DotModel> generateDotsForYear(int year);
  Future<List<DotModel>> getLifeDots(int ageYears);
  Future<void> saveNote(DateTime week, String note);
  Future<void> addMilestone(DateTime week, MilestoneModel milestone);
}
