import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/app_config_provider.dart';

class ThemeBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      color: provider.isDarkMode()
          ? Color.fromARGB(255, 20, 25, 34)
          : Colors.white,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                provider.changeTheme(ThemeMode.light);
              },
              child: provider.isDarkMode()
                  ? getUnSelectedItemStyle('Light', context)
                  : getSelectedItemStyle('Light', context),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                provider.changeTheme(ThemeMode.dark);
              },
              child: provider.isDarkMode()
                  ? getSelectedItemStyle('Dark', context)
                  : getUnSelectedItemStyle('Dark', context),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSelectedItemStyle(String text, BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: provider.isDarkMode() ? Colors.white : Colors.black,
          ),
        ),
        Icon(
          Icons.check,
          color: provider.isDarkMode() ? Colors.white : Colors.black,
        ),
      ],
    );
  }

  Widget getUnSelectedItemStyle(String text, BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: provider.isDarkMode() ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}
