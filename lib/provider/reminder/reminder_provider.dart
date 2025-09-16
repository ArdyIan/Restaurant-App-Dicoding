import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_api_dicoding/utils/notification_helper.dart';

class ReminderProvider extends ChangeNotifier {
  bool _isReminderOn = false;
  bool get isReminderOn => _isReminderOn;

  ReminderProvider() {
    _loadReminder();
  }

  Future<void> toggleReminder(bool value) async {
    _isReminderOn = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isReminderOn", value);

    if (value) {
      await NotificationHelper.showDailyReminder();
    } else {
      await NotificationHelper.cancelReminder();
    }

    notifyListeners();
  }

  Future<void> _loadReminder() async {
    final prefs = await SharedPreferences.getInstance();
    _isReminderOn = prefs.getBool("isReminderOn") ?? false;

    if (_isReminderOn) {
      await NotificationHelper.showDailyReminder();
    }

    notifyListeners();
  }
}
