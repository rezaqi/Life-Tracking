// features/life_calendar/presentation/widgets/milestone_marker.dart
import 'package:flutter/material.dart';

import '../../data/models/milestone_model.dart';

class MilestoneMarker extends StatelessWidget {
  final List<MilestoneModel> milestones;
  final double size;

  const MilestoneMarker({super.key, required this.milestones, this.size = 6});

  @override
  Widget build(BuildContext context) {
    if (milestones.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: milestones.map((milestone) {
        return Container(
          width: size,
          height: size,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
          child: Tooltip(
            message: milestone.title,
            child: const SizedBox.shrink(),
          ),
        );
      }).toList(),
    );
  }
}
