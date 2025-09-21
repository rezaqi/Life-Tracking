// features/life_calendar/presentation/bloc/life_state.dart

import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/features/life_celendar/presentation/bloc/life_event.dart';

import '../../data/models/dot_model.dart';

class LifeState {
  final List<DotModel> dots;
  final ViewType viewType;
  final bool isLoading;
  RequestState? requestState;

  LifeState({
    this.dots = const [],
    this.requestState,
    this.viewType = ViewType.weeks,
    this.isLoading = false,
  });

  LifeState copyWith({
    RequestState? requestState,
    List<DotModel>? dots,
    ViewType? viewType,
    bool? isLoading,
  }) {
    return LifeState(
      requestState: requestState ?? this.requestState,
      dots: dots ?? this.dots,
      viewType: viewType ?? this.viewType,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [dots, viewType, isLoading];
}

class LifeStateInit extends LifeState {
  LifeStateInit() : super(requestState: RequestState.init);
}
