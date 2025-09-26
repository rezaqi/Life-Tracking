import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:life_tracking/features/life_celendar/presentation/pages/life_calendar_page.dart';
import 'package:life_tracking/features/life_celendar/presentation/widgets/life_progress_page.dart';
import 'package:life_tracking/features/life_tracker/presentation/page/life_tracker.dart';
import 'package:life_tracking/features/moments/presentation/page/momrnts.dart';
import 'package:life_tracking/features/tabs/presentaion/manager/state_tab.dart';
import 'package:life_tracking/features/tabs/presentaion/manager/tab_event.dart';

@injectable
class TabBloc extends Bloc<TabsEvent, TabsState> {
  int indexScreen = 0;
  String title = "Home";

  TextEditingController searchController = TextEditingController();

  static TabBloc get(context) => BlocProvider.of(context);
  TabBloc() : super(TabInitState()) {
    on<OnTabEvent>((event, emit) {
      emit(state.copyWith(indexScreen: event.index));
    });
  }

  void changeScreen(int val, BuildContext context) {
    if (val == 0) {
      title = "Dashboard";
    } else if (val == 1) {
      title = "progress";
    } else if (val == 2) {
      title = "Account";
    } else if (val == 3) {
      title = "Settings";
    }

    add(OnTabEvent(index: val));
  }

  List tabs = [
    LifeTrackerHome(),
    LifeCalendarPage(),
    MomentsPage(),
    LifeProgressWidget(),
  ];
}
