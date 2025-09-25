import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FancyAnimatedRing extends StatefulWidget {
  final double progressTarget;
  const FancyAnimatedRing({super.key, required this.progressTarget});
  @override
  State<FancyAnimatedRing> createState() => _FancyAnimatedRingState();
}

class _FancyAnimatedRingState extends State<FancyAnimatedRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  Animation<double>? _anim; // مش final علشان نقدر نعيد تهيئته
  late double _currentTarget;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _setAnimation(widget.progressTarget);
    _ctrl.forward();
  }

  void _setAnimation(double end) {
    _anim = Tween<double>(
      begin: 0.0,
      end: end,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void restartWith(double newTarget) {
    setState(() {
      _currentTarget = newTarget;
      _ctrl.reset();
      _setAnimation(_currentTarget);
      _ctrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 16.h),
        AnimatedBuilder(
          animation: _ctrl,
          builder: (context, child) {
            final value = _anim?.value ?? 0.0;
            return CustomPaint(
              painter: _RingPainter(progress: value),
              size: const Size(100, 100),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                    '${(value * 100).toInt()}%',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 16.h),
        ElevatedButton(
          onPressed: () {
            print(widget.progressTarget);
            final newTarget = _currentTarget + 0.01;
            print(newTarget);
            restartWith(newTarget);
          },
          child: const Text('Change & Animate'),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  _RingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = min(size.width, size.height) / 1.5;

    // خلفية الحلقة
    final bgPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    // لون التقدم (نقدر نغيّره حسب النسبة)
    final progPaint = Paint()
      ..shader = SweepGradient(
        startAngle: -pi / 2,
        endAngle: -pi / 2 + 2 * pi * progress,
        stops: const [0.0, 1.0],
        colors: [Colors.blue, Colors.purple],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    // نرسم الخلفية كاملة
    canvas.drawCircle(center, radius - 7, bgPaint);

    // نرسم قوس التقدم
    final startAngle = -pi / 2; // يبدأ من فوق
    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 7),
      startAngle,
      sweepAngle,
      false,
      progPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) => old.progress != progress;
}
