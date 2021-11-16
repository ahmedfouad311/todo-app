import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/home/home_screen.dart';
import 'package:todoapp/theme/my_theme_data.dart';

void main() async {
  //dol 2aham satren 3l4an 22dar 23ml connect le el database
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'todo App',
      theme: MyThemeData.LIGHT_THEME,
      routes: {
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
      },
      initialRoute: HomeScreen.ROUTE_NAME,
    );
  }
}
