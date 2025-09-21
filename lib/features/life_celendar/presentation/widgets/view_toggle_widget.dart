// features/life_calendar/presentation/widgets/view_toggle_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/life_bloc.dart';
import '../bloc/life_event.dart';

class ViewToggleWidget extends StatelessWidget {
  const ViewToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: ViewType.values.map((type) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ElevatedButton(
            onPressed: () {
              context.read<LifeBloc>().add(ToggleViewEvent(type));
            },
            child: Text(type.name.toUpperCase()),
          ),
        );
      }).toList(),
    );
  }
}
