import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Retries a Firestore operation with exponential backoff on 'unavailable' exceptions.
Future<T> retryFirestoreOperation<T>(
  Future<T> Function() operation, {
  int maxRetries = 3,
  Duration initialDelay = const Duration(seconds: 1),
}) async {
  int attempt = 0;
  Duration delay = initialDelay;

  while (attempt < maxRetries) {
    try {
      return await operation();
    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' && attempt < maxRetries - 1) {
        attempt++;
        // Exponential backoff with jitter
        final jitter = Random().nextInt(1000); // up to 1 second jitter
        await Future.delayed(delay + Duration(milliseconds: jitter));
        delay *= 2; // double the delay
      } else {
        rethrow;
      }
    }
  }
  throw FirebaseException(
    plugin: 'cloud_firestore',
    code: 'max-retries-exceeded',
    message:
        'Operation failed after $maxRetries retries due to service unavailability.',
  );
}
