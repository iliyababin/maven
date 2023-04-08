
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../theme/m_themes.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {

  String selectedThemeId = '';

  @override
  Widget build(BuildContext context) {
    if(selectedThemeId.isEmpty) {
      selectedThemeId = ThemeProvider.themeOf(context).id;
    }

    List<AppTheme> themes = ThemeProvider.controllerOf(context).allThemes;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Theme',
          style: TextStyle(
            color: mt(context).text.primaryColor,
          ),
        ),
      ),
      body: ListView(
        children: themes.map((theme) {
          return Theme(
            data: ThemeData(
                unselectedWidgetColor: Colors.yellow
            ),
            child: RadioListTile(
              title: Text(
                theme.description,
                style: TextStyle(
                    color: mt(context).text.primaryColor
                ),
              ),
              value: theme.id,
              onChanged:(value) {
                setState(() {
                  selectedThemeId = value!;
                  ThemeProvider.controllerOf(context).setTheme(theme.id);
                });
              },
              groupValue: selectedThemeId,
            ),
          );
        }).toList(),
      ),
    );
  }
}
