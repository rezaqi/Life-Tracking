import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthDotsWidget extends StatelessWidget {
  final int year;
  final int month;
  final int livedWeeks;
  final DateTime birthDate;
  final int currentGlobalWeek;

  const MonthDotsWidget({
    super.key,
    required this.year,
    required this.month,
    required this.livedWeeks,
    required this.birthDate,
    required this.currentGlobalWeek,
  });

  @override
  Widget build(BuildContext context) {
    DateTime firstDay = DateTime(year, month, 1);

    List<Widget> dots = [];
    for (int i = 0; i < 4; i++) {
      DateTime weekStart = firstDay.add(Duration(days: i * 7));
      int globalWeek =
          ((weekStart.difference(birthDate).inDays) / 7).floor() + 1;
      Color color = _getColor(globalWeek);
      dots.add(
        GestureDetector(
          onTap: () {
            // TODO: Open week details or add memory
          },
          child: Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.MMM().format(firstDay),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: dots),
        ],
      ),
    );
  }

  Color _getColor(int globalWeek) {
    if (globalWeek % 520 == 0) {
      return Colors.red;
    } else if (globalWeek % 260 == 0) {
      return Colors.blue;
    } else if (globalWeek <= livedWeeks) {
      if (globalWeek == currentGlobalWeek) {
        return Colors.yellow;
      } else {
        return Colors.black;
      }
    } else {
      return Colors.grey[300]!;
    }
  }
}
