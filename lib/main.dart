import 'package:flutter/material.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/theme/my_theme_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo App',
      theme: MyThemeData.LIGHT_THEME,
      routes: {
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
      },
      initialRoute: HomeScreen.ROUTE_NAME,
    );
  }
}
