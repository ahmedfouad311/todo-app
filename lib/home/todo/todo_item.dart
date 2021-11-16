import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/home/data/firestoreUtils.dart';
import 'package:todoapp/home/data/todo.dart';

class TodoItem extends StatelessWidget {

  Todo item;

  TodoItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(), //el behaviour bta3 el slider
      actions: [
        IconSlideAction(
          color: Colors.transparent,
          iconWidget: Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  'Delete',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            deleteTodo(item).then((value) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text('Task Deleted Successfully'),
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
          },
        ),
      ],
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Colors.redAccent,
        child: Container(
          color: Colors.white,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 70,
                  color: Theme.of(context).primaryColor,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(
                          '${item.dateTime.day}/${item.dateTime.month}/${item
                              .dateTime.year}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Image(
                      image: AssetImage('assets/images/icon_check.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
