import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_tracking/features/life_celendar/presentation/pages/year_view_page.dart';

class LifeInWeeks extends StatefulWidget {
  final String birthday;
  final int lifeExpectancy;

  const LifeInWeeks({
    super.key,
    required this.birthday,
    required this.lifeExpectancy,
  });

  @override
  State<LifeInWeeks> createState() => _LifeInWeeksState();
}

class _LifeInWeeksState extends State<LifeInWeeks>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late List<Color> _dotColors;

  @override
  void initState() {
    super.initState();
    final totalWeeks = widget.lifeExpectancy * 52;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Precompute colors
    final DateTime birthDate = _parseBirthday(widget.birthday);
    final DateTime now = DateTime.now();
    final int daysLived = now.difference(birthDate).inDays;
    final int livedWeeks = (daysLived / 7).floor();

    _dotColors = List.generate(totalWeeks, (index) {
      bool isMilestone = (index + 1) % 520 == 0;
      bool isAdventure = (index + 1) % 260 == 0;

      if (isMilestone) {
        return Colors.yellow;
      } else if (isAdventure) {
        return Colors.grey;
      } else if (index < livedWeeks) {
        return Colors.black;
      } else {
        return Colors.grey[300]!;
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DateTime _parseBirthday(String birthday) {
    if (birthday.trim().isEmpty) return DateTime(2000, 1, 1);
    try {
      return DateTime.parse(birthday); // yyyy-MM-dd
    } catch (_) {
      try {
        return DateFormat("d/M/yyyy").parse(birthday); // dd/MM/yyyy
      } catch (_) {
        return DateTime.now();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime birthDate = _parseBirthday(widget.birthday);
    final DateTime now = DateTime.now();

    final int daysLived = now.difference(birthDate).inDays;
    final int livedWeeks = (daysLived / 7).floor();
    final int totalWeeks = widget.lifeExpectancy * 52;

    // ارتفاع الكونتينر الثابت (تقدر تغيره)
    const double gridHeight = 300;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.grey[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Your Life in Weeks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 10),

            // الكونتينر ثابت الارتفاع — كل النقاط لازم تدخل هنا (بدون scroll)
            SizedBox(
              height: gridHeight,
              width: double.infinity,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double width = constraints.maxWidth;
                  final int columns = 52;
                  final int rows = (totalWeeks / columns).ceil().clamp(
                    1,
                    10000,
                  );
                  final double cellWidth = width / columns;
                  final double cellHeight = gridHeight / rows;
                  // حجم الخانة الفعلي (نختار الأصغر عشان نضمن الملاءمة)
                  final double cellSize = min(cellWidth, cellHeight);
                  // حجم النقطة داخل الخانة (نسبة من الخانة)
                  double dotSize = cellSize * 0.6;
                  // اجعل النقطة على الأقل 2px علشان تظهر
                  if (dotSize < 2) dotSize = 2;

                  // نسبة العرض/الارتفاع للخانة للـ Grid
                  final double childAspectRatio =
                      (cellWidth / (cellHeight == 0 ? 1 : cellHeight));

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: 0,
                      childAspectRatio: childAspectRatio,
                    ),
                    itemCount: totalWeeks,
                    itemBuilder: (context, index) {
                      int year = birthDate.year + (index ~/ 52);

                      return Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => YearViewPage(
                                  year: year,
                                  birthday: widget.birthday,
                                  lifeExpectancy: widget.lifeExpectancy,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: dotSize,
                            height: dotSize,
                            decoration: BoxDecoration(
                              color: _dotColors[index],
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: _dotColors[index].withOpacity(0.5),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(width: 10, height: 10, color: Colors.black),
                    const SizedBox(width: 6),
                    const Text('Lived'),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Container(width: 10, height: 10, color: Colors.blue),
                    const SizedBox(width: 6),
                    const Text('Adventure'),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Container(width: 10, height: 10, color: Colors.red),
                    const SizedBox(width: 6),
                    const Text('Milestone'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
