import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

// Only import dart:html on web
// ignore: uri_does_not_exist
import 'dart:html' as html;

class NotificationsHelper {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (kIsWeb) return;
    if (_initialized) return;

    tzdata.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    _initialized = true;
  }

  /// 1️⃣ Show delayed notification (for testing/demo)
  static Future<void> showDelayedNotification(
      String title, String body,
      {int delaySeconds = 5}) async {
    if (kIsWeb) {
      Future.delayed(Duration(seconds: delaySeconds), () {
        if (html.Notification.supported) {
          html.Notification.requestPermission().then((permission) {
            if (permission == "granted") {
              html.Notification(title, body: body);
            }
          });
        }
      });
    } else {
      await initialize();
      final scheduledTime =
          tz.TZDateTime.now(tz.local).add(Duration(seconds: delaySeconds));

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'exam_channel',
        'Exam Reminders',
        channelDescription: 'Reminders for competitive exams',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails platformDetails =
          NotificationDetails(android: androidDetails);

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        scheduledTime,
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: null,
      );
    }
  }

  /// 2️⃣ Schedule notification at exact datetime
  static Future<void> scheduleNotificationAtDate(
      String title, String body, DateTime scheduledDate) async {
    if (kIsWeb) {
      final now = DateTime.now();
      final delay = scheduledDate.difference(now);
      if (delay.isNegative) return; // skip past dates

      Future.delayed(delay, () {
        if (html.Notification.supported) {
          html.Notification.requestPermission().then((permission) {
            if (permission == "granted") {
              html.Notification(title, body: body);
            }
          });
        }
      });
    } else {
      await initialize();
      final scheduledTime = tz.TZDateTime.from(scheduledDate, tz.local);

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
        'exam_channel',
        'Exam Reminders',
        channelDescription: 'Reminders for competitive exams',
        importance: Importance.max,
        priority: Priority.high,
      );

      const NotificationDetails platformDetails =
          NotificationDetails(android: androidDetails);

      await _flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        title,
        body,
        scheduledTime,
        platformDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: null,
      );
    }
  }
}