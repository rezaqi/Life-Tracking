import 'package:flutter/material.dart';

class AgeSlider extends StatefulWidget {
  final Function(int)? onAgeChanged; // Callback

  const AgeSlider({super.key, this.onAgeChanged});

  @override
  State<AgeSlider> createState() => _AgeSliderState();
}

class _AgeSliderState extends State<AgeSlider> {
  double _age = 85; // القيمة الافتراضية

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.cyan,
            inactiveTrackColor: Colors.grey.shade300,
            thumbColor: Colors.cyan,
            overlayColor: Colors.cyan.withOpacity(0.2),
            trackHeight: 6,
          ),
          child: Slider(
            value: _age,
            min: 70,
            max: 100,
            divisions: 30, // سنة بسنة
            label: _age.round().toString(),
            onChanged: (value) {
              setState(() {
                _age = value;
              });

              // نرجع القيمة للأب (IntroScreen)
              if (widget.onAgeChanged != null) {
                widget.onAgeChanged!(_age.round());
              }
            },
          ),
        ),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("70", style: TextStyle(fontSize: 16)),
            Text("85", style: TextStyle(fontSize: 16)),
            Text("100", style: TextStyle(fontSize: 16)),
          ],
        ),

        const SizedBox(height: 25),

        Text(
          "${_age.round()} years old 🎉",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
        ),
      ],
    );
  }
}
