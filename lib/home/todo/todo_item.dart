import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/home/data/firestoreUtils.dart';
import 'package:todoapp/home/data/todo.dart';
import 'package:todoapp/home/todo/edit_screen.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/theme/my_theme_data.dart';

class TodoItem extends StatelessWidget {

  Todo item;

  TodoItem(this.item);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
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
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
                context, EditScreen.ROUTE_NAME, arguments: item);
          },
          child: Container(
            color: provider.isDarkMode() ? Color.fromARGB(255, 20, 25, 34) :
            Colors.white,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: provider.isDarkMode() ? Color.fromARGB(255, 20, 25, 34) :
                Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 70,
                    color: item.isDone ? MyThemeData.GREEN_COLOR_ISDONE :
                    Theme
                        .of(context)
                        .primaryColor,
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
                            style: item.isDone ? Theme
                                .of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                              color: MyThemeData.GREEN_COLOR_ISDONE,
                            )
                                : Theme
                                .of(context)
                                .textTheme
                                .headline6,
                          ),
                          Text(
                            '${item.dateTime.day}/${item.dateTime.month}/${item
                                .dateTime.year}',
                            style: provider.isDarkMode() ? TextStyle(
                                color: Colors.white,
                                fontSize: 16) :
                            Theme
                                .of(context)
                                .textTheme
                                .subtitle2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  item.isDone ? InkWell(
                    onTap: () {
                      editIsDone(item);
                    },
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Text(
                        'Done!',
                        style: TextStyle(
                          color: MyThemeData.GREEN_COLOR_ISDONE,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ) :
                  InkWell(
                    onTap: () {
                      editIsDone(item);
                    },
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
      ),
    );
  }
}
