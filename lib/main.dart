import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/home/todo/edit_screen.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/theme/my_theme_data.dart';

void main() async {
  //dol 2aham satren 3l4an 22dar 23ml connect le el database
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) {
        return AppConfigProvider();
      },
      child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  late AppConfigProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppConfigProvider>(context);
    sharedPref();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'todo App',
      theme: MyThemeData.LIGHT_THEME,
      darkTheme: MyThemeData.DARK_THEME,
      themeMode: provider.appTheme,
      routes: {
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
        EditScreen.ROUTE_NAME: (context) => EditScreen()
      },
      initialRoute: HomeScreen.ROUTE_NAME,
    );
  }

  void sharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    provider.changeLanguage(preferences.getString('Language') ?? 'en');

    if (preferences.getString('theme') == 'light') {
      provider.changeTheme(ThemeMode.light);
    }
    else if (preferences.getString('theme') == 'dark') {
      provider.changeTheme(ThemeMode.dark);
    }
  }
}
