import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  //class by4el el data el lma tt8ayar hat2asar 3ala el behaviour bta3 el application
  ThemeMode appTheme = ThemeMode.system;

  void changeTheme(ThemeMode newMode) {
    if (newMode == appTheme) {
      return;
    }
    appTheme = newMode;
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }
}
