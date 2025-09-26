import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LifeProgressWidget extends StatelessWidget {
  const LifeProgressWidget({Key? key}) : super(key: key);

  Future<Map<String, dynamic>?> _fetchUserLifeData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return null;

      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      return doc.exists ? doc.data() : null;
    } catch (e) {
      debugPrint("Error fetching life data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _fetchUserLifeData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text(
              "No data available",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final userData = snapshot.data!;
        final int age = userData["age"] ?? 0;
        final int lifeExpectancy = userData["lifeExpectancy"] ?? 70;

        double progress = (lifeExpectancy > 0) ? age / lifeExpectancy : 0;
        progress = progress.clamp(0, 1);

        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " Life Progress: ${(progress * 100).toStringAsFixed(1)}% of your life",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    color: Colors.teal,
                    backgroundColor: Colors.teal.withOpacity(0.2),
                    minHeight: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$age years lived',
                      style: TextStyle(color: Colors.black54),
                    ),
                    SizedBox(width: 8),
                    Text('•', style: TextStyle(color: Colors.black26)),
                    SizedBox(width: 8),
                    Text(
                      '$lifeExpectancy remain',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
