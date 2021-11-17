import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/home/data/firestoreUtils.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/theme/my_theme_data.dart';

class AddTodoBottomSheet extends StatefulWidget {
  @override
  _AddTodoBottomSheetState createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {

  var formKey = GlobalKey<FormState>(); // 3l4an el validation
  DateTime selectedDate = DateTime.now();

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.isDarkMode() ? MyThemeData.DARK_BACKGROUND_COLOR :
      Colors.white,
      child: Container(
        color: provider.isDarkMode() ? MyThemeData.DARK_BACKGROUND_COLOR :
        Colors.white,
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Add new Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: provider.isDarkMode() ? Colors.white :
                Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: provider.isDarkMode()
                            ? Colors.white
                            :
                        Colors.black),
                      ),
                      labelText: 'Title',
                      labelStyle: TextStyle(
                        color: provider.isDarkMode() ? Colors.white :
                        Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please Enter Todo Title';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      title = text;
                    },
                    style: TextStyle(
                      color: provider.isDarkMode() ? Colors.white :
                      Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: provider.isDarkMode() ? Colors.white :
                      Colors.black,
                    ),
                    onChanged: (text) {
                      description = text;
                    },
                    maxLines: 4,
                    minLines: 4,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: provider.isDarkMode()
                            ? Colors.white
                            :
                        Colors.black),
                      ),
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        color: provider.isDarkMode() ? Colors.white :
                        Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Please Enter Todo Description';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Select Time',
                style: TextStyle(
                  color: provider.isDarkMode() ? Colors.white :
                  Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showDateDialog();
              },
              child: Text(
                '${selectedDate.day}/${selectedDate.month}/${selectedDate
                    .year}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: provider.isDarkMode() ? Colors.white :
                  Colors.black45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                addTodo();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  'Add',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addTodo() {
    // 1- get title and description
    // 2- select date
    // 3- create todo and add it to the database

    if (!formKey.currentState!.validate()) {
      return;
    }
    addTodoToFirestore(title, description, selectedDate).then((value) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Task Added Successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ],
          );
        },
      );
    }).onError((error, stackTrace) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Error'),
          );
        },
      );
    }).timeout(Duration(seconds: 10), onTimeout: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Session Timed out'),
          );
        },
      );
    });
  }

  void showDateDialog() async {
    var newSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      setState(() {

      });
    }
  }
}
