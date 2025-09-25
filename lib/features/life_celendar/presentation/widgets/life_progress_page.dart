import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LifeProgressPage extends StatelessWidget {
  const LifeProgressPage({Key? key}) : super(key: key);

  Future<Map<String, dynamic>?> _getUserLifeData() async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid) // حط الـ uid بتاع اليوزر الحالي
        .get();

    if (doc.exists) {
      return doc.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('شريط تقدم الحياة'), centerTitle: true),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _getUserLifeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("لا توجد بيانات"));
          }

          final userData = snapshot.data!;
          final int age = userData["age"] ?? 0;
          final int lifeExpectancy = userData["lifeExpectancy"] ?? 70;

          double progress = 0;
          if (lifeExpectancy > 0) {
            progress = age / lifeExpectancy;
            if (progress > 1) progress = 1; // علشان مايزودش عن 100%
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "عمرك: $age سنة",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "متوسط العمر المتوقع: $lifeExpectancy سنة",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: progress,
                  color: Colors.teal,
                  backgroundColor: Colors.teal.withOpacity(0.2),
                  minHeight: 14,
                ),
                const SizedBox(height: 12),
                Text(
                  "لقد عشت ${(progress * 100).toStringAsFixed(1)}% من حياتك",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
