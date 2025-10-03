import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:life_tracking/core/utils/firestore_retry.dart';
import 'package:life_tracking/features/life_celendar/data/datasources/dm.dart';
import 'package:life_tracking/features/life_celendar/data/models/day_model.dart';

@Injectable(as: DmLifeCalender)
class LifeCalenderDataSourceImpl extends DmLifeCalender {
  @override
  Future<List<String>> uploadImageToCloudinary(List<File> imageFiles) async {
    const cloudName = "drqqmi6hz"; // حط اسم حسابك
    const uploadPreset = "unsigned_preset"; // حط الـ preset بتاعك

    final url = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    List<String> uploadedUrls = [];

    for (var imageFile in imageFiles) {
      final request = http.MultipartRequest("POST", url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();
      final body = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final resJson = json.decode(body);
        uploadedUrls.add(resJson['secure_url']);
      } else {
        debugPrint('Cloudinary error (${response.statusCode}): $body');
        // لو صورة فشلت ممكن تكمل الباقي أو توقف
      }
    }

    return uploadedUrls;
  }

  @override
  Future<void> saveDay(
    BuildContext context,
    List<File> imageFiles,
    String docId,
    String title,
    String des,
    String mood,
    String date,
  ) async {
    List<String> imageUrls = await uploadImageToCloudinary(imageFiles);

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(date));

    await retryFirestoreOperation(() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("days")
          .doc(docId)
          .set({
            "title": title,
            "description": des,
            "mood": mood,
            "images": imageUrls,
            "date": formattedDate,
          });
    });
  }

  @override
  Future<DayModel?> getDayMemory(String userId, String date) async {
    try {
      final formattedDate = DateFormat(
        'yyyy-MM-dd',
      ).format(DateTime.parse(date));

      final snapshot = await retryFirestoreOperation(() async {
        return await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .collection("days")
            .where("date", isEqualTo: formattedDate) // 👈 مطابق
            .limit(1)
            .get();
      });

      if (snapshot.docs.isNotEmpty) {
        return DayModel.fromMap(
          snapshot.docs.first.data(),
          docId: snapshot.docs.first.id,
        );
      }
      return null;
    } catch (e) {
      throw Exception("Failed to fetch day memory: $e");
    }
  }
}
