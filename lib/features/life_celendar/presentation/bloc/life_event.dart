// features/life_calendar/presentation/bloc/life_event.dart
import 'package:equatable/equatable.dart';

import '../../data/models/milestone_model.dart';

/// Abstract base class for all Life events
abstract class LifeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event: Load Life dots (for a specific year)
class LoadLifeDots extends LifeEvent {
  final int year; // السنة المراد عرضها
  LoadLifeDots(this.year);

  @override
  List<Object?> get props => [year];
}

/// Event: Add a note to a specific week
class AddNoteEvent extends LifeEvent {
  final DateTime week;
  final String note;

  AddNoteEvent(this.week, this.note);

  @override
  List<Object?> get props => [week, note];
}

/// Event: Add a milestone to a specific week
class AddMilestoneEvent extends LifeEvent {
  final DateTime week;
  final MilestoneModel milestone;

  AddMilestoneEvent(this.week, this.milestone);

  @override
  List<Object?> get props => [week, milestone];
}

/// Event: Toggle between different views (Weeks / Months / Years)
class ToggleViewEvent extends LifeEvent {
  final ViewType viewType;

  ToggleViewEvent(this.viewType);

  @override
  List<Object?> get props => [viewType];
}

/// Enum: Defines the view type for Life Calendar
enum ViewType { weeks, months, years }
