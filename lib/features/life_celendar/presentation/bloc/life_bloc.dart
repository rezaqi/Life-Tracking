import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:life_tracking/core/class/faiiur.dart';
import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/features/life_celendar/domain/repositories/life_repository.dart';
import 'package:life_tracking/features/life_celendar/domain/usecase/usecase.dart';

import '../../data/models/milestone_model.dart';
import 'life_event.dart';
import 'life_state.dart';

@injectable
class LifeBloc extends Bloc<LifeEvent, LifeState> {
  final LifeRepository _repo;
  final UseCaseLifeCalender useCase;
  static LifeBloc get(context) => BlocProvider.of(context);
  LifeBloc(this._repo, this.useCase) : super(LifeStateInit()) {
    on<LoadLifeDots>((event, emit) {
      // هنا نستخدم generateDotsForYear بدل generateDots لكل العمر
      final int currentYear = DateTime.now().year;
      final dots = _repo.generateDotsForYear(currentYear); // 👈 هنا
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

    on<UploadImageToCloudinaryEvent>((event, emit) async {
      emit(state.copyWith(requestStateUploadImage: RequestState.loading));
      try {
        var res = await useCase.call(event.file);
        res.fold(
          (error) {
            emit(
              state.copyWith(
                requestStateUploadImage: RequestState.error,
                failureUploadImage: error,
              ),
            );
          },
          (success) {
            emit(
              state.copyWith(
                requestStateUploadImage: RequestState.success,
                imagesLinksUploaded: success,
              ),
            );
          },
        );
      } catch (e) {
        emit(
          state.copyWith(
            requestStateUploadImage: RequestState.error,
            failureUploadImage: Failure(e.toString()),
          ),
        );
      }
    });

    on<OnSaveDay>((event, emit) async {
      emit(state.copyWith(requestStateSaveDay: RequestState.loading));

      try {
        await useCase.callSaveDay(
          event.context,
          state.imageFiles,
          state.docId ?? DateTime.now().millisecondsSinceEpoch.toString(),
          state.title ?? "",
          state.des ?? "",
          state.mood ?? "",
          state.date ?? DateTime.now().toIso8601String(),
        );
        emit(state.copyWith(requestStateSaveDay: RequestState.success));
      } catch (e) {
        emit(state.copyWith(requestStateSaveDay: RequestState.error));
      }
    });

    on<OnAddImages>((event, emit) {
      emit(state.copyWith(imageFiles: [...state.imageFiles, ...event.images]));
    });

    on<OnChangeMood>((event, emit) {
      emit(state.copyWith(mood: event.mood));
    });

    on<OnChangeTitle>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<OnChangeDescription>((event, emit) {
      emit(state.copyWith(des: event.description));
    });
    on<OnRemoveImage>((event, emit) {
      final updatedImages = List<File>.from(state.imageFiles)
        ..remove(event.image);
      emit(state.copyWith(imageFiles: updatedImages));
    });
    on<LoadDayMemory>((event, emit) async {
      emit(state.copyWith(requestStateSaveDay: RequestState.loading));
      try {
        final memory = await _repo.getDayMemory(
          event.userId,
          event.date.toString(),
        );

        if (memory != null) {
          emit(
            state.copyWith(
              requestStateSaveDay: RequestState.success,
              title: memory.title,
              des: memory.description,
              mood: memory.mood,
              //   imageFiles: memory.imageUrls, // لو بترجع File
              imagesLinksUploaded: memory.imageUrls, // لو لينكات
              date: event.date.toIso8601String(),
              hasMemory: true, // 👈 نضيف فلاغ
            ),
          );
        } else {
          emit(
            state.copyWith(
              requestStateSaveDay: RequestState.init,
              hasMemory: false,
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(requestStateSaveDay: RequestState.error));
      }
    });
  }
}
