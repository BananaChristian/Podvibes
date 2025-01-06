import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:podvibes/themes/themes.dart';


class ThemeProvider with ChangeNotifier {
  bool _isDarkMode;

  // Constructor: Initialize with device's default theme
  ThemeProvider()
      : _isDarkMode =
            // ignore: deprecated_member_use
            SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  // Get current theme data
  ThemeData get themeData => _isDarkMode ? darkMode : lightMode;

  // Get current mode
  bool get isDarkMode => _isDarkMode;

  // Toggle between light and dark mode
  void toggleThemes() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}