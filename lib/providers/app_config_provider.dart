import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  //class by4el el data el lma tt8ayar hat2asar 3ala el behaviour bta3 el application
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.system;

  void changeLanguage(String newLanguage) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (newLanguage == appLanguage) {
      return;
    }
    appLanguage = newLanguage;
    preferences.setString('Language', newLanguage);
    notifyListeners();
  }


  void changeTheme(ThemeMode newMode) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (newMode == appTheme) {
      return;
    }
    appTheme = newMode;
    preferences.setString(
        'theme', newMode == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }


  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}
