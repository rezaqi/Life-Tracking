import 'package:injectable/injectable.dart';
import 'package:life_tracking/features/dashboard/data/model/LifeExpectancy.dart';
import 'package:life_tracking/features/dashboard/data/source/source.dart';
import 'package:life_tracking/features/dashboard/doman/repo.dart';

@Injectable(as: LifeExpectancyRepository)
class LifeExpectancyRepositoryImpl implements LifeExpectancyRepository {
  final LifeExpectancyDataSource dataSource;

  LifeExpectancyRepositoryImpl(this.dataSource);

  @override
  Future<LifeExpectancyModel?> getLifeExpectancy(String country) {
    return dataSource.getLifeExpectancy(country);
  }
}
