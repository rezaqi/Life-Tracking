import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LifeWeeksWidget extends StatelessWidget {
  final int currentAge; // العمر الحالي
  final int lifeExpectancy; // العمر المتوقع

  const LifeWeeksWidget({
    Key? key,
    required this.currentAge,
    required this.lifeExpectancy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int weeksLived = (currentAge * 52);
    int weeksLeft = ((lifeExpectancy - currentAge) * 52);

    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Life Progress",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoBox("Weeks Lived", weeksLived),
                _infoBox("Weeks Left", weeksLeft),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoBox(String title, int value) {
    final formatter = NumberFormat("#,###");
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Text(
          formatter.format(value),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ],
    );
  }
}
