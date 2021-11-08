import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todoapp/home/todo/todo_item.dart';

class TodoListTab extends StatefulWidget {
  @override
  _TodoListTabState createState() => _TodoListTabState();
}

class _TodoListTabState extends State<TodoListTab> {
  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          TableCalendar(
            onDaySelected: (sDay, fDay) {
              setState(() {
                selectedDay = sDay;
                focusedDay = fDay;
              });
            },
            selectedDayPredicate: (day) {
              //el function de 3l4an 23ml select le ay yom 3ady w yzhar fe el ui
              return isSameDay(day,
                  selectedDay); //bydeni yom w bys2alni el yom dah 2nta 3ayzo yb2a selected walla la
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
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(8)),
              defaultTextStyle: TextStyle(
                color: Colors.black,
              ),
              defaultDecoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                weekdayStyle: TextStyle(
                  color: Colors.black,
                )),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TodoItem();
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
