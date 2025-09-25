import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_tracking/core/class/colors.dart';
import 'package:life_tracking/features/tabs/presentaion/manager/state_tab.dart';
import 'package:life_tracking/features/tabs/presentaion/manager/tab_bloc.dart';
import 'package:life_tracking/features/tabs/presentaion/widget/tab_customer.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabBloc(),
      child: BlocBuilder<TabBloc, TabsState>(
        builder: (context, state) {
          final bloc = TabBloc.get(context);

          return Scaffold(
            body: SafeArea(child: bloc.tabs[state.indexScreen]),

            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 60,
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: state.indexScreen,
                    iconSize: 24, // 👈 تصغير الأيقونات لو حبيت
                    selectedFontSize: 10, // 👈 حجم النص لو مفعل

                    onTap: (index) => bloc.changeScreen(index, context),
                    backgroundColor: AppColors.pri,
                    items: [
                      BottomNavigationBarItem(
                        icon: CustomTabWidget(
                          bloc: bloc,
                          index: 0,
                          icon: Icons.home,
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: CustomTabWidget(
                          bloc: bloc,
                          index: 1,
                          icon: Icons.emoji_events_outlined,
                        ),
                        label: "",
                      ),

                      BottomNavigationBarItem(
                        icon: CustomTabWidget(
                          bloc: bloc,
                          index: 2,
                          icon: Icons.person,
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: CustomTabWidget(
                          bloc: bloc,
                          index: 3,
                          icon: Icons.settings,
                        ),
                        label: "",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
