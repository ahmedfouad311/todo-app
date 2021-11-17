import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/home/todo/add_todo_widget.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/theme/my_theme_data.dart';

import 'settings/settings_tab.dart';
import 'todo/todo_list_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String ROUTE_NAME = 'Home Screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> tabs = [
    TodoListTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: provider.isDarkMode()
            ? MyThemeData.DARK_PRIMARY_COLOR
            :
        Theme
            .of(context)
            .primaryColor,
        elevation: 0,
        title: Text(
            'To Do Applicatipn',
            style: TextStyle(
              color: provider.isDarkMode() ? Colors.black :
              Colors.white,
            )
        ),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: provider.isDarkMode()
            ? MyThemeData.DARK_PRIMARY_COLOR
            :
        Theme
            .of(context)
            .primaryColor,
        shape: StadiumBorder( // el border el 7awalen el button
          side: BorderSide(
            color: Colors.white,
            width: 4,
          ),
        ),
        onPressed: () {
          showAddTodoSheet();
        },
        child: Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar( // 3l4an 23raf 23ml el notch el ta7t
        clipBehavior: Clip.antiAlias,
        notchMargin: 8,
        elevation: 0,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: provider.isDarkMode()
                ? Color.fromARGB(255, 20, 25, 34)
                :
            Colors.white,
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              currentIndex = index;
              setState(() {

              });
            },
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                backgroundColor: provider.isDarkMode() ? Color.fromARGB(
                    255, 20, 25, 34) :
                Colors.white,
                label: '',
                icon: Icon(Icons.list,
                  color: provider.isDarkMode() ? Colors.white :
                  Colors.grey,
                  size: 30,
                ),
              ),
              BottomNavigationBarItem(
                backgroundColor: provider.isDarkMode() ? Color.fromARGB(
                    255, 20, 25, 34) :
                Colors.white,
                label: '',
                icon: Icon(Icons.settings,
                  color: provider.isDarkMode() ? Colors.white :
                  Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
      body: tabs[currentIndex],
    );
  }

  void showAddTodoSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddTodoBottomSheet();
      },
    );
  }
}
