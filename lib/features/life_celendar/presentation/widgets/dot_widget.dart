// import 'package:flutter/material.dart';

// import '../../data/models/dot_model.dart';

// class DotWidget extends StatelessWidget {
//   final DotModel dot;
//   final VoidCallback onTap;

//   const DotWidget({super.key, required this.dot, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     // تحديد اللون بناءً على حالة الدوت
//     Color color;
//     if (dot.isPast) {
//       color = Colors.grey.shade800; // رمادي غامق للماضي
//     } else if (dot.isPresent) {
//       color = Colors.amberAccent; // مضيء / حاضر
//     } else {
//       color = Colors.grey.shade400; // رمادي فاتح للمستقبل
//     }

//     return GestureDetector(
//       onTap: onTap,
//       child: Tooltip(
//         message:
//             "Week of ${dot.weekDate.day}-${dot.weekDate.month}-${dot.weekDate.year}",
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           margin: const EdgeInsets.all(2),
//           width: 30,
//           height: 30,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//             boxShadow: [
//               if (dot.isPresent)
//                 BoxShadow(
//                   color: Colors.amberAccent.withOpacity(0.5),
//                   blurRadius: 6,
//                   spreadRadius: 1,
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
