import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_tracking/features/life_celendar/domain/repositories/life_repository.dart';

import '../../data/models/milestone_model.dart';
import 'life_event.dart';
import 'life_state.dart';

class LifeBloc extends Bloc<LifeEvent, LifeState> {
  LifeRepository lifeRepository;
  LifeBloc(this.lifeRepository) : super(LifeStateInit()) {
    on<LoadLifeDots>((event, emit) {
      // هنا نستخدم generateDotsForYear بدل generateDots لكل العمر
      final int currentYear = DateTime.now().year;
      final dots = lifeRepository.generateDotsForYear(currentYear); // 👈 هنا
      emit(state.copyWith(dots: dots, isLoading: false));
    });

    on<AddNoteEvent>((event, emit) {
      final updatedDots = state.dots.map((dot) {
        if (dot.weekDate == event.week) {
          return dot.copyWith(note: event.note);
        }
        return dot;
      }).toList();
      emit(state.copyWith(dots: updatedDots));
    });

    on<AddMilestoneEvent>((event, emit) {
      final updatedDots = state.dots.map((dot) {
        if (dot.weekDate == event.week) {
          final updatedMilestones = List<MilestoneModel>.from(dot.milestones)
            ..add(event.milestone);
          return dot.copyWith(milestones: updatedMilestones);
        }
        return dot;
      }).toList();
      emit(state.copyWith(dots: updatedDots));
    });

    on<ToggleViewEvent>((event, emit) {
      emit(state.copyWith(viewType: event.viewType));
    });
  }
}
