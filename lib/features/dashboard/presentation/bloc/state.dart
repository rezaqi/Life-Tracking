import 'package:equatable/equatable.dart';
import 'package:life_tracking/features/dashboard/data/model/LifeExpectancy.dart';

abstract class LifeExpectancyState extends Equatable {
  const LifeExpectancyState();

  @override
  List<Object?> get props => [];
}

class LifeInitial extends LifeExpectancyState {}

class LifeLoading extends LifeExpectancyState {}

class LifeLoaded extends LifeExpectancyState {
  final LifeExpectancyModel expectancy;
  final double progress;

  const LifeLoaded(this.expectancy, this.progress);

  @override
  List<Object?> get props => [expectancy, progress];
}

class LifeError extends LifeExpectancyState {
  final String message;
  const LifeError(this.message);

  @override
  List<Object?> get props => [message];
}
