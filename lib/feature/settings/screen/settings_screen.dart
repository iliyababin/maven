import 'package:Maven/feature/settings/screen/theme_screen.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../widget/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(
        title: "Settings",
        context: context,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: const Icon(Icons.palette),
                title: const Text('Theme'),
                description: Text(ThemeProvider.themeOf(context).description),
                trailing: Icon(Icons.keyboard_arrow_right),
                onPressed: (context) async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ThemeScreen())
                  );
                  /*String cool = await showThemeSelectionDialog(context);
                  ThemeProvider.controllerOf(context).addTheme(cool);*/
                },
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                value: const Text('English'),
              ),
              SettingsTile.navigation(
                title: const Text("test"),
                value: const Text("welp"),
                leading: const Icon(Icons.telegram_sharp),
                onPressed: (context) {},
              )
            ],
          ),
          SettingsSection(
              tiles: <SettingsTile>[SettingsTile(title: const Text("cool"))])
        ],
      ),
    );
  }

  Future<String> showThemeSelectionDialog(BuildContext context) async {
    // Show the dialog
    final selectedOption = await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select an option'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'dark_theme');
            },
            child: Text('Option 1'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'light_theme');
            },
            child: Text('Option 2'),
          ),
        ],
      ),
    );

    // Return the selected option
    return selectedOption;
  }
}
