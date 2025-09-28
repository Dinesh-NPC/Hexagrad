import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: null,
      macOS: null,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  // Show notification immediately
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    if (kIsWeb) {
      // Web cannot show local notifications, just print
      print("Notification (Web): $title - $body");
      return;
    }

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'hexa_grad_channel',
      'HexaGrad Notifications',
      channelDescription: 'Notifications for HexaGrad exams and scholarships',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );
  }

  // Schedule notification at a specific time
  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    if (kIsWeb) {
      // Web cannot schedule notifications; show immediately
      await showNotification(title: title, body: body);
      return;
    }

    final tz.TZDateTime tzScheduled = tz.TZDateTime.from(scheduledTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tzScheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'hexa_grad_channel',
          'HexaGrad Notifications',
          channelDescription: 'Notifications for HexaGrad exams and scholarships',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // optional: daily notifications
    );
  }
}
