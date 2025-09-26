import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedDots extends StatefulWidget {
  final int totalDots; // عدد النقط كلها
  final Duration duration; // سرعة التغيير

  const AnimatedDots({
    super.key,
    this.totalDots = 15,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> {
  int _filledDots = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(widget.duration, (timer) {
      setState(() {
        if (_filledDots < 6) {
          _filledDots++;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.totalDots, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Text(
            index < _filledDots ? "●" : "○",
            style: const TextStyle(fontSize: 30),
          ),
        );
      }),
    );
  }
}
