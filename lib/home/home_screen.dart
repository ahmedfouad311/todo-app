import 'package:flutter/material.dart';
import 'package:todoapp/home/todo/add_todo_widget.dart';

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'To Do Applicatipn',
        ),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
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
              label: '',
              icon: Icon(Icons.list,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Icon(Icons.settings,
                size: 30,
              ),
            ),
          ],
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
