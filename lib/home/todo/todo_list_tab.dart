import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoapp/home/data/firestoreUtils.dart';
import 'package:todoapp/home/data/todo.dart';
import 'package:todoapp/home/todo/todo_item.dart';
import 'package:todoapp/providers/app_config_provider.dart';

class TodoListTab extends StatefulWidget {
  @override
  _TodoListTabState createState() => _TodoListTabState();
}

class _TodoListTabState extends State<TodoListTab> {
  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          TableCalendar(
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonDecoration: BoxDecoration(
                border: Border.all(color: provider.isDarkMode() ? Colors.white :
                Colors.black
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              formatButtonTextStyle: TextStyle(
                color: provider.isDarkMode() ? Colors.white :
                Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: provider.isDarkMode() ? Colors.white :
                Colors.black,
              ),
            ),
            onDaySelected: (sDay, fDay) {
              setState(() {
                selectedDay = sDay;
                focusedDay = fDay;
              });
            },
            selectedDayPredicate: (day) {
              //el function de 3l4an 23ml select le ay yom 3ady w yzhar fe el ui
              return isSameDay(
                  day, selectedDay); //bydeni yom w bys2alni el yom dah 2nta
              // 3ayzo yb2a selected walla la
            },
            calendarFormat: CalendarFormat.week,
            weekendDays: [],
            //3l4an kan 3aml 2n el sabt w el 7ad disabled maynfa34 23mlhom select
            focusedDay: focusedDay,
            //maynfa34 25tar focused day sabet 3l4an lma 2agy 25trar 7aga tany mayraga3ne4 tany 3ala el month el 2na feh
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            calendarStyle: CalendarStyle(
              // dah el theme bta3 el clanedar
              selectedTextStyle: TextStyle(
                color: Colors.white,
              ),
              selectedDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  // by default law ma3arft4 el primary colo byb2a blue
                  borderRadius: BorderRadius.circular(8)),
              todayTextStyle: TextStyle(
                color: Colors.white,
              ),
              todayDecoration: BoxDecoration(
                  color: provider.isDarkMode() ? Colors.white :
                  Colors.black45,
                  borderRadius: BorderRadius.circular(8)),
              defaultTextStyle: TextStyle(
                color: provider.isDarkMode() ? Colors.white :
                Colors.black,
              ),
              defaultDecoration: BoxDecoration(
                  color: provider.isDarkMode()
                      ? Color.fromARGB(255, 20, 25, 34)
                      :
                  Colors.white,
                  borderRadius: BorderRadius.circular(8)
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
                decoration: BoxDecoration(
                  color: provider.isDarkMode()
                      ? Color.fromARGB(255, 20, 25, 34)
                      :
                  Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                weekdayStyle: TextStyle(
                  color: provider.isDarkMode() ? Colors.white :
                  Colors.black,
                )),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<
                Todo>>( //3l4an el data el hatt3erd fe el widget de lazem 2stanaha mn el firestore
              stream: getTodosCollectionWithConverter()
              // el where 3l4an 2akaren el selectedday be el dateTime el mawgod 3l4an y7ot kol task fe el day bta3ha
                  .where('dateTime',
                  isEqualTo:
                  selectedDay
                      .getDateOnly()
                      .millisecondsSinceEpoch)
                  .snapshots(),
              builder: (BuildContext buildContext,
                  AsyncSnapshot<QuerySnapshot<Todo>> snapshot) {
                if (snapshot.hasError) { // Error
                  return Center(child: Text(snapshot.hasError.toString()));
                }
                else if (snapshot.connectionState ==
                    ConnectionState.waiting) { // loading
                  return Center(child: CircularProgressIndicator());
                }
                // data is ready
                // el doc gayba el todo fa 3ayz 2a7awel el list bta3t el doc le list of
                //  todo item w de fekrt el satr el ta7t dah
                List<Todo> items = snapshot.data!.docs.map((doc) => doc.data())
                    .toList();
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return TodoItem(items[index]);
                  },
                  itemCount: items.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
