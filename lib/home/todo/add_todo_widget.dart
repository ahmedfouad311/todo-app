import 'package:flutter/material.dart';
import 'package:todoapp/home/data/firestoreUtils.dart';

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
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Add new Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
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
                    labelText: 'Title',
                    labelStyle: TextStyle(
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
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onChanged: (text) {
                    description = text;
                  },
                  maxLines: 4,
                  minLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
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
                color: Colors.black,
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
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
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
