
import 'package:Maven/l10n/screen/language_screen.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../equipment/screen/equipment_screen.dart';
import 'theme_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: SettingsList(
        /*lightTheme: SettingsThemeData(
          settingsSectionBackground: T.current.foregroundColor,
          settingsListBackground: T.current.backgroundColor,
          leadingIconsColor: T.current.icon.secondaryColor,
          settingsTileTextColor: T.current.text.primaryColor,
          dividerColor: T.current.borderColor,
          titleTextColor: T.current.text.primaryColor,
          trailingTextColor: T.current.text.secondaryColor,
        ),*/
        platform: DevicePlatform.iOS,
        sections: [
          SettingsSection(
              title: const Text('GENERAL'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EquipmentScreen()));
                  },
                  leading: const Icon(Icons.home_repair_service_rounded),
                  title: const Text('Equipment'),
                ),
              ]
          ),
          SettingsSection(
            title: const Text('APPEARANCE'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.palette),
                title: const Text('Theme'),
                value: Text(ThemeProvider.themeOf(context).description),
                onPressed: (context) async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ThemeScreen())
                  );
                  /*String cool = await showThemeSelectionDialog(context);
                  ThemeProvider.controllerOf(context).addTheme(cool);*/
                },
              ),
            ],
          ),
          SettingsSection(
              title: const Text('LOCALIZATION'),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  onPressed: (context) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageScreen()));
                  },
                  leading: const Icon(Icons.language),
                  title: const Text('Language'),
                ),
              ]
          ),
        ],
      ),
    );
  }

  Future<String> showThemeSelectionDialog(BuildContext context) async {
    // Show the dialog
    final selectedOption = await showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select an option'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'dark_theme');
            },
            child: const Text('Option 1'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'light_theme');
            },
            child: const Text('Option 2'),
          ),
        ],
      ),
    );

    // Return the selected option
    return selectedOption;
  }
}
