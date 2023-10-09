import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_foresight/data/models/item.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_logo');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  // notificationDetals() {
  //   return const NotificationDetails(
  //       android: AndroidNotificationDetails("channelId", "channelName",
  //           importance: Importance.max),
  //       iOS: DarwinNotificationDetails());
  // }

  Future scheduleNotification(int id, String title, String body, String payload,
      tz.TZDateTime scheduledDate) async {
    await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        NotificationDetails(
            android: AndroidNotificationDetails(
                json.decode(payload)['id'], 'Food Foresight',
                channelDescription: 'your channel description')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload);
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    try {
      const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails('your channel id', 'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker');
      const NotificationDetails notificationDetails =
          NotificationDetails(android: androidNotificationDetails);
      await notificationsPlugin.show(id, title, body, notificationDetails,
          payload: 'item x');
    } catch (e) {
      print(e);
    }
  }

  clearAll() async {
    await notificationsPlugin.cancelAll();
  }

  void clear(int notificationId) async {
    await notificationsPlugin.cancel(notificationId);
  }

  Future<List<PendingNotificationRequest>> getScheduledNotifications() async {
    var pendingNotifications =
        await notificationsPlugin.pendingNotificationRequests();
    print(pendingNotifications.length);
    return pendingNotifications;
  }
}
