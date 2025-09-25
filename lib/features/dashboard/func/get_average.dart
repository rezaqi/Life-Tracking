import 'package:life_tracking/features/dashboard/const/average_country.dart';

double getAverageAgeByGender(String country, String gender) {
  return averageAgeByCountryAndGender[country]?[gender] ?? 0.0;
}
