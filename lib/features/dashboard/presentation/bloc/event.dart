import 'package:equatable/equatable.dart';

abstract class LifeExpectancyEvent extends Equatable {
  const LifeExpectancyEvent();

  @override
  List<Object?> get props => [];
}

class FetchLifeExpectancy extends LifeExpectancyEvent {
  final String country;
  final String gender;
  final int age;

  const FetchLifeExpectancy(this.country, this.gender, this.age);

  @override
  List<Object?> get props => [country, gender, age];
}
