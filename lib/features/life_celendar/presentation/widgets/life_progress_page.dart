import 'package:flutter/material.dart';

// Widget مخصص لشريط التقدم للفئة
class CategoryProgressBar extends StatelessWidget {
  final String category;
  final double progress;
  final Color color;

  const CategoryProgressBar({
    Key? key,
    required this.category,
    required this.progress,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          color: color,
          backgroundColor: color.withOpacity(0.2),
          minHeight: 8,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}

// الصفحة الرئيسية للوحة تقدم الحياة
class LifeProgressPage extends StatelessWidget {
  const LifeProgressPage({Key? key}) : super(key: key);

  // بيانات وهمية للفئات
  final List<Map<String, dynamic>> categories = const [
    {'name': 'وظيفية', 'progress': 0.7, 'color': Colors.blue},
    {'name': 'صحية', 'progress': 0.5, 'color': Colors.green},
    {'name': 'أطفال', 'progress': 0.3, 'color': Colors.orange},
    {'name': 'سفر', 'progress': 0.6, 'color': Colors.purple},
    {'name': 'تحديث', 'progress': 0.8, 'color': Colors.red},
  ];

  @override
  Widget build(BuildContext context) {
    // حساب التقدم الكلي (متوسط الفئات)
    double totalProgress =
        categories.fold<double>(
          0,
          (sum, cat) => sum + (cat['progress'] as double),
        ) /
        categories.length;

    return Scaffold(
      appBar: AppBar(title: Text('لوحة تقدم الحياة'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'التقدم الكلي',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: totalProgress,
              color: Colors.teal,
              backgroundColor: Colors.teal.withOpacity(0.2),
              minHeight: 12,
            ),
            SizedBox(height: 24),
            Text(
              'الفئات',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ...categories.map(
              (cat) => CategoryProgressBar(
                category: cat['name'],
                progress: cat['progress'],
                color: cat['color'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
