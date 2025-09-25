import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:life_tracking/features/dashboard/data/model/LifeExpectancy.dart';

abstract class LifeExpectancyDataSource {
  Future<LifeExpectancyModel?> getLifeExpectancy(String country);
}

@LazySingleton(as: LifeExpectancyDataSource)
class LifeExpectancyDataSourceImpl implements LifeExpectancyDataSource {
  final FirebaseFirestore firestore;

  LifeExpectancyDataSourceImpl(this.firestore);

  @override
  Future<LifeExpectancyModel?> getLifeExpectancy(String country) async {
    final doc = await firestore.collection("lifeExpectancy").doc(country).get();
    if (!doc.exists) return null;
    return LifeExpectancyModel.fromFirestore(doc.data()!);
  }
}
