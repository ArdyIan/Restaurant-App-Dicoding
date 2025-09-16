import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // Inisialisasi timezone
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInit = DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _notifications.initialize(initSettings);
  }

  /// Schedule daily reminder → sementara untuk testing, 2 menit dari sekarang
  static Future<void> showDailyReminder() async {
    final scheduledTime = _nextInstanceOfTest();
    print("Reminder dijadwalkan pada: $scheduledTime");
    print("Sekarang: ${tz.TZDateTime.now(tz.local)}");
    print("Reminder target: $scheduledTime");

    await _notifications.zonedSchedule(
      0,
      'Daily Reminder',
      'Jangan lupa cek restoran favoritmu hari ini!',
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel',
          'Daily Reminder',
          channelDescription: 'Notifikasi harian pukul 11:00',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Test notifikasi instan
  static Future<void> showTestNotification() async {
    await _notifications.show(
      1,
      'Test Notification',
      'Ini notifikasi test',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Channel',
          channelDescription: 'Channel untuk testing',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  /// Jadwal 2 menit dari sekarang (untuk debugging cepat)
  static tz.TZDateTime _nextInstanceOfTest() {
    final now = tz.TZDateTime.now(tz.local);
    return now.add(const Duration(minutes: 2));
  }

  /// Jadwal normal jam 11:00
  static tz.TZDateTime _nextInstanceOf11AM() {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  /// Batalkan reminder
  static Future<void> cancelReminder() async {
    await _notifications.cancel(0);
  }
}