import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_tracking/core/class/colors.dart';
import 'package:life_tracking/features/tabs/presentaion/manager/state_tab.dart';
import 'package:life_tracking/features/tabs/presentaion/manager/tab_bloc.dart';

class CustomTabWidget extends StatelessWidget {
  final TabBloc bloc;
  final int index;
  final IconData icon;
  const CustomTabWidget({
    Key? key,
    required this.bloc,
    required this.index,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabsState>(
      bloc: bloc,
      builder: (context, state) {
        bool isSelected = state.indexScreen == index;
        return Container(
          padding: isSelected
              ? EdgeInsets.symmetric(horizontal: 20.w, vertical: 2.h)
              : EdgeInsets.zero,
          decoration: isSelected
              ? BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                )
              : BoxDecoration(),
          child: Icon(
            icon,
            color: isSelected ? AppColors.sec : AppColors.white,
          ),
        );
      },
    );
  }
}
