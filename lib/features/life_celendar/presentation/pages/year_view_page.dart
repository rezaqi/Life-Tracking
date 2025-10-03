import 'package:flutter/material.dart';
import 'package:life_tracking/features/moments/presentation/widget/add_memory_modal.dart';

import '../widgets/month_dots_widget.dart';

class YearViewPage extends StatefulWidget {
  final int year;
  final String birthday;
  final int lifeExpectancy;

  const YearViewPage({
    super.key,
    required this.year,
    required this.birthday,
    required this.lifeExpectancy,
  });

  @override
  State<YearViewPage> createState() => _YearViewPageState();
}

class _YearViewPageState extends State<YearViewPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _slideAnimations = List.generate(
      12,
      (index) => Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: _controller,
              curve: Interval(
                index / 12 * 0.8,
                (index + 1) / 12 * 0.8 + 0.2,
                curve: Curves.easeOut,
              ),
            ),
          ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime birthDate = DateTime.parse(widget.birthday);
    DateTime now = DateTime.now();
    int daysLived = now.difference(birthDate).inDays;
    int livedWeeks = (daysLived / 7).floor();
    int currentGlobalWeek =
        ((now.difference(birthDate).inDays) / 7).floor() + 1;

    int age = widget.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Year: ${widget.year} (Age ${age + 1})'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[50]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => YearViewPage(
                            year: widget.year - 1,
                            birthday: widget.birthday,
                            lifeExpectancy: widget.lifeExpectancy,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text(
                    'Year: ${widget.year} (Age ${age + 1})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => YearViewPage(
                            year: widget.year + 1,
                            birthday: widget.birthday,
                            lifeExpectancy: widget.lifeExpectancy,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, monthIndex) {
                    int month = monthIndex + 1;
                    return SlideTransition(
                      position: _slideAnimations[monthIndex],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: MonthDotsWidget(
                          year: widget.year,
                          month: month,
                          livedWeeks: livedWeeks,
                          birthDate: birthDate,
                          currentGlobalWeek: currentGlobalWeek,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '[Tap a week to add a memory]',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddMemoryModal(),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Memory or Milestone'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
