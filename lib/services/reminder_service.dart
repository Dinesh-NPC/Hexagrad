import 'package:cloud_firestore/cloud_firestore.dart';
import 'notification_service.dart';

class ReminderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> schedulePersonalizedReminders(String userId) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    final interests = List<String>.from(userDoc.data()?['interests'] ?? []);

    if (interests.isEmpty) return;

    final now = DateTime.now();

    final snapshot = await _firestore
        .collection('reminders')
        .where('topic', whereIn: interests)
        .where('dateTime', isGreaterThanOrEqualTo: now)
        .get();

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final title = data['title'] ?? 'Reminder';
      final description = data['description'] ?? '';
      final dateTime = (data['dateTime'] as Timestamp).toDate();

      final scheduledTime = dateTime.subtract(Duration(hours: 1));
      if (scheduledTime.isAfter(now)) {
        await NotificationService().scheduleNotification(
          title: title,
          body: description,
          scheduledTime: scheduledTime,
        );
      }
    }
  }
}
