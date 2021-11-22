import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  //class by4el el data el lma tt8ayar hat2asar 3ala el behaviour bta3 el application
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.dark;

  void changeLanguage(String LanguageCode) {
    if (LanguageCode == appLanguage) {
      return;
    }
    appLanguage = LanguageCode;
    notifyListeners();
  }

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
