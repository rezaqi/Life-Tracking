import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:life_tracking/core/class/routs_name.dart';
import 'package:life_tracking/features/adventures/presentation/page/adventures_hub_page.dart';
import 'package:life_tracking/features/auth/domain/auth_service.dart';
import 'package:life_tracking/features/life_celendar/presentation/pages/life_calendar_page.dart';
import 'package:life_tracking/features/life_tracker/presentation/page/life_tracker.dart';
import 'package:life_tracking/features/profile/presentation/page/profile_page.dart';
import 'package:life_tracking/features/social_hub/presentation/page/social_hub_page.dart';
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
      title = "Life Calendar";
    } else if (val == 2) {
      title = "Adventures Hub";
    } else if (val == 3) {
      title = "Social Hub";
    } else if (val == 4) {
      title = "Profile";
    }

    add(OnTabEvent(index: val));
  }

  List<Widget> getActions(BuildContext context) {
    if (indexScreen == 1) {
      return [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRouts.lifeEventPlanningPage);
          },
          icon: Icon(Icons.event),
        ),
        IconButton(
          onPressed: () async {
            final AuthService authService = context.read<AuthService>();
            await authService.logout(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRouts.login,
              (r) => false,
            );
          },
          icon: Icon(Icons.logout),
        ),
      ];
    } else if (indexScreen == 4) {
      return [
        IconButton(
          icon: Icon(Icons.settings, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, AppRouts.settings);
          },
        ),
      ];
    }
    return [];
  }

  List tabs = [
    LifeTrackerHome(),
    LifeCalendarPage(),
    AdventuresHubPage(),
    SocialHubPage(),
    ProfilePage(),
  ];
}
