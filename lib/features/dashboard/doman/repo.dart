import 'package:life_tracking/features/dashboard/data/model/LifeExpectancy.dart';

abstract class LifeExpectancyRepository {
  Future<LifeExpectancyModel?> getLifeExpectancy(String country);
}
