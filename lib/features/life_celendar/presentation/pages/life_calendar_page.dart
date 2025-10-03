import 'package:collection/collection.dart'; // firstOrNull
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:life_tracking/core/class/shared_preferences.dart';
import 'package:life_tracking/features/auth/domain/user.dart';
import 'package:life_tracking/features/life_celendar/data/models/dot_model.dart';
import 'package:life_tracking/features/life_celendar/presentation/bloc/life_bloc.dart';
import 'package:life_tracking/features/life_celendar/presentation/bloc/life_event.dart';
import 'package:life_tracking/features/life_celendar/presentation/bloc/life_state.dart';
import 'package:life_tracking/features/life_celendar/presentation/pages/dayDetailsPage.dart';
import 'package:life_tracking/features/life_celendar/presentation/widgets/lifeWeeksWidget.dart';
import 'package:life_tracking/features/life_celendar/presentation/widgets/life_in_weeks.dart';
import 'package:life_tracking/features/life_celendar/presentation/widgets/life_progress_page.dart';

class LifeCalendarPage extends StatefulWidget {
  const LifeCalendarPage({super.key});

  @override
  State<LifeCalendarPage> createState() => _LifeCalendarPageState();
}

class _LifeCalendarPageState extends State<LifeCalendarPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final DateFormat dateFormat = DateFormat('dd MMM');
  DateTime currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
  String viewMode = 'Monthly';
  final List<String> viewOptions = ['Weekly', 'Monthly', 'Yearly'];
  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
    _fadeController.forward();
    _loadUser();
    context.read<LifeBloc>().add(LoadLifeDots(DateTime.now().year));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Color _getCellColor(DateTime cellDate, DotModel? dot, DateTime today) {
    bool isToday =
        cellDate.year == today.year &&
        cellDate.month == today.month &&
        cellDate.day == today.day;

    bool isPast = cellDate.isBefore(today) && !isToday;
    bool isFuture = cellDate.isAfter(today) && !isToday;

    // الأولوية: اليوم -> الماضي -> المستقبل -> dot
    if (isToday) return Colors.amber;
    if (isPast) return Colors.grey[700]!;
    if (isFuture) return Colors.grey[400]!;

    // لو مش أي حالة فوق، يبقى استخدم لون الـ dot لو موجود
    if (dot != null) return dot.color;

    return Colors.grey[400]!;
  }

  bool isSameDate(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }

  Future<void> _loadUser() async {
    UserModel? user = await UserPrefs.getUser();
    setState(() {
      userModel = user;
    });
  }

  Future<void> _clearUser() async {
    await UserPrefs.clearUser();
    setState(() {
      userModel = null;
    });
  }

  List<Widget> _buildDayHeaders() {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return days
        .map(
          (d) => Center(
            child: Text(
              d,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double w = size.width;
    double h = size.height;

    return BlocConsumer<LifeBloc, LifeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var bloc = LifeBloc.get(context);
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey[50]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Good day, ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          userModel?.name ?? "there",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        Text(
                          "! 👋",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.02),
                    SizedBox(
                      height: 120.h, // ممكن تغير على حسب اللي انت عايزه
                      child: LifeProgressWidget(),
                    ),
                    LifeWeeksWidget(currentAge: 25, lifeExpectancy: 96),

                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       const Text(
                    //         "View: ",
                    //         style: TextStyle(fontWeight: FontWeight.bold),
                    //       ),
                    //       DropdownButton<String>(
                    //         value: viewMode,
                    //         items: viewOptions
                    //             .map(
                    //               (e) => DropdownMenuItem(
                    //                 value: e,
                    //                 child: Text(e),
                    //               ),
                    //             )
                    //             .toList(),
                    //         onChanged: (val) {
                    //           setState(() {
                    //             viewMode = val!;
                    //           });
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: h * 0.6, // أو أي نسبة مناسبة
                      child: BlocBuilder<LifeBloc, LifeState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (userModel == null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          var birthday = userModel!.birthday;
                          if (birthday == null || birthday.trim().isEmpty) {
                            birthday = "2000-01-01"; // تاريخ افتراضي
                          }

                          return LifeInWeeks(
                            birthday: birthday,
                            lifeExpectancy: userModel!.lifeExpectancy ?? 90,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWeeklyCalendar(
    LifeState state,
    DateTime today,
    LifeBloc blocLife,
  ) {
    final startOfWeek = today.subtract(Duration(days: today.weekday % 7));
    List<DateTime> weekDates = List.generate(
      7,
      (i) => startOfWeek.add(Duration(days: i)),
    );
    const dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // لمنع scroll داخلي
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 أيام في الأسبوع
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.1, // يسمح بمساحة للـ text أعلى المربع
      ),
      itemCount: weekDates.length,
      itemBuilder: (context, index) {
        final cellDate = weekDates[index];
        final dayName = dayNames[cellDate.weekday % 7];

        final DotModel? dot = state.dots
            .where(
              (d) =>
                  d.weekDate.day == cellDate.day &&
                  d.weekDate.month == cellDate.month &&
                  d.weekDate.year == cellDate.year,
            )
            .cast<DotModel?>()
            .firstOrNull;

        bool isToday =
            cellDate.day == today.day &&
            cellDate.month == today.month &&
            cellDate.year == today.year;
        bool isPast = cellDate.isBefore(today) && !isToday;

        return GestureDetector(
          onTap: () => _openDayDetails(cellDate, blocLife, state),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                dayName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  color: isToday
                      ? Colors.amber
                      : isPast
                      ? Colors.grey[700]
                      : Colors.grey[400],
                  shape: BoxShape.circle,
                ),
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: Text(
                  cellDate.day.toString(),
                  style: TextStyle(
                    color: isToday ? Colors.black : Colors.white,
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMonthlyCalendar(
    LifeState state,
    double w,
    DateTime today,
    LifeBloc blocLife,
  ) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );
    final totalDays = lastDayOfMonth.day;
    final startWeekday = firstDayOfMonth.weekday % 7;

    List<TableRow> rows = [];
    rows.add(TableRow(children: _buildDayHeaders()));

    int dayCounter = 1 - startWeekday;
    while (dayCounter <= totalDays) {
      List<Widget> weekCells = [];
      for (int i = 0; i < 7; i++) {
        if (dayCounter < 1 || dayCounter > totalDays) {
          weekCells.add(Container());
        } else {
          final cellDate = DateTime(
            currentMonth.year,
            currentMonth.month,
            dayCounter,
          );
          weekCells.add(_buildDayCell(cellDate, state, blocLife));
        }
        dayCounter++;
      }
      rows.add(TableRow(children: weekCells));
    }

    return SingleChildScrollView(
      child: Table(defaultColumnWidth: FixedColumnWidth(w / 8), children: rows),
    );
  }

  Widget _buildYearlyCalendar(
    LifeState state,
    DateTime today,
    LifeBloc blocLife,
  ) {
    List<Widget> months = [];
    for (int month = 1; month <= 12; month++) {
      final firstDay = DateTime(today.year, month, 1);
      months.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.MMMM().format(firstDay),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: List.generate(
                  DateTime(today.year, month + 1, 0).day,
                  (i) {
                    final cellDate = DateTime(today.year, month, i + 1);
                    return _buildSmallDayCell(cellDate, state, today, blocLife);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(child: Column(children: months));
  }

  Widget _buildDayCell(DateTime cellDate, LifeState state, LifeBloc blocLife) {
    final today = DateTime.now();

    final DotModel? dot = state.dots.firstWhereOrNull(
      (d) => isSameDate(d.weekDate, cellDate),
    );

    final bgColor = _getCellColor(cellDate, dot, today);

    return GestureDetector(
      onTap: () => _openDayDetails(cellDate, blocLife, state),
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 50,
        width: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (dot != null && dot.imageUrl != null)
              ClipOval(
                child: Image.network(
                  dot.imageUrl!,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
              ),
            Text(
              cellDate.day.toString(),
              style: TextStyle(
                color: bgColor == Colors.amber ? Colors.black : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallDayCell(
    DateTime cellDate,
    LifeState state,
    DateTime today,
    LifeBloc blocLife,
  ) {
    final DotModel? dot = state.dots
        .where(
          (d) =>
              d.weekDate.day == cellDate.day &&
              d.weekDate.month == cellDate.month &&
              d.weekDate.year == cellDate.year,
        )
        .cast<DotModel?>()
        .firstOrNull;

    bool isToday =
        cellDate.year == today.year &&
        cellDate.month == today.month &&
        cellDate.day == today.day;
    bool isPast = cellDate.isBefore(today) && !isToday;

    return GestureDetector(
      onTap: () => _openDayDetails(cellDate, blocLife, state),
      child: Container(
        margin: const EdgeInsets.all(2),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isToday
              ? Colors.amber
              : isPast
              ? Colors.grey[700]
              : Colors.grey[400],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            cellDate.day.toString(),
            style: TextStyle(
              fontSize: 10,
              color: isToday ? Colors.black : Colors.white,
              fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  void _openDayDetails(
    DateTime date,
    LifeBloc blocLife,
    LifeState state,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DayDetailsPage(
          bloc: blocLife,
          state: state,
          date: date,
          userId: userModel?.id ?? "guest", // الـ userId بتاعك
        ),
      ),
    );

    if (result != null) {
      // بعد ما ترجع من الصفحة تحدث البيانات من Firestore
      context.read<LifeBloc>().add(LoadLifeDots(DateTime.now().year));
    }
  }
}
