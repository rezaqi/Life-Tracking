// features/life_calendar/presentation/bloc/life_state.dart

import 'dart:io';

import 'package:life_tracking/core/class/faiiur.dart';
import 'package:life_tracking/core/class/request_state.dart';
import 'package:life_tracking/features/life_celendar/presentation/bloc/life_event.dart';

import '../../data/models/dot_model.dart';

class LifeState {
  final List<DotModel> dots;
  final ViewType viewType;
  final bool isLoading;
  RequestState? requestState;
  List<String?>? imagesLinksUploaded;
  RequestState? requestStateUploadImage;
  Failure? failureUploadImage;
  RequestState? requestStateSaveDay;
  final List<File> imageFiles;
  String? docId;
  String? title;
  String? des;
  String? mood;
  String? date;
  final bool hasMemory;

  LifeState({
    this.dots = const [],
    this.requestState,
    this.viewType = ViewType.weeks,
    this.requestStateUploadImage,
    this.failureUploadImage,
    this.isLoading = false,
    this.hasMemory = false,
    this.imagesLinksUploaded,
    this.requestStateSaveDay,
    this.imageFiles = const [],
    this.docId,
    this.title,
    this.des,
    this.mood,
    this.date,
  });

  LifeState copyWith({
    RequestState? requestState,
    RequestState? requestStateUploadImage,
    RequestState? requestStateSaveDay,
    List<DotModel>? dots,
    bool? hasMemory,
    ViewType? viewType,
    bool? isLoading,
    Failure? failureUploadImage,
    List<String?>? imagesLinksUploaded,
    List<File>? imageFiles,
    String? docId,
    String? title,
    String? des,
    String? mood,
    String? date,
  }) {
    return LifeState(
      hasMemory: hasMemory ?? this.hasMemory,
      imageFiles: imageFiles ?? this.imageFiles,
      imagesLinksUploaded: imagesLinksUploaded ?? this.imagesLinksUploaded,
      requestState: requestState ?? this.requestState,
      requestStateSaveDay: requestStateSaveDay ?? this.requestStateSaveDay,
      requestStateUploadImage:
          requestStateUploadImage ?? this.requestStateUploadImage,
      dots: dots ?? this.dots,
      viewType: viewType ?? this.viewType,
      isLoading: isLoading ?? this.isLoading,
      failureUploadImage: failureUploadImage ?? this.failureUploadImage,

      date: date ?? this.date,
      des: des ?? this.des,
      docId: docId ?? this.docId,
      mood: mood ?? this.mood,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [dots, viewType, isLoading];
}

class LifeStateInit extends LifeState {
  LifeStateInit()
    : super(
        requestState: RequestState.init,
        requestStateUploadImage: RequestState.init,
      );
}
