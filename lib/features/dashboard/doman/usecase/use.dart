import 'package:injectable/injectable.dart';
import 'package:life_tracking/features/dashboard/data/model/LifeExpectancy.dart';
import 'package:life_tracking/features/dashboard/doman/repo.dart';

@injectable
class GetLifeExpectancy {
  final LifeExpectancyRepository repository;

  GetLifeExpectancy(this.repository);

  Future<LifeExpectancyModel?> call(String country) {
    return repository.getLifeExpectancy(country);
  }
}
