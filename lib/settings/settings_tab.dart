import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/providers/app_config_provider.dart';
import 'package:todoapp/settings/theme_bottomSheet.dart';

class SettingsTab extends StatefulWidget {
  @override
  _SettingsTabState createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Theme',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: provider.isDarkMode() ? Colors.white : Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              ShowThemeBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appTheme == ThemeMode.light ? 'Light' : 'Dark',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void ShowThemeBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ThemeBottomSheet();
        });
  }
}
