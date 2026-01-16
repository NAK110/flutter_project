import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkModeChecked = true;

  void toggleTheme({required bool darkMode}) async {
    isDarkModeChecked = darkMode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkModeChecked', darkMode);
    notifyListeners();
  }

  void loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkModeChecked = prefs.getBool('isDarkModeChecked') ?? true;
    notifyListeners();
  }
}
