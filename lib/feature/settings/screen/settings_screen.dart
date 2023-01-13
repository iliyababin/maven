import 'package:Maven/feature/settings/screen/theme_screen.dart';
import 'package:Maven/theme/m_themes.dart';
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
        lightTheme: SettingsThemeData(
          settingsSectionBackground: mt(context).foregroundColor,
          settingsListBackground: mt(context).backgroundColor,
          leadingIconsColor: mt(context).icon.secondaryColor,
          settingsTileTextColor: mt(context).text.primaryColor,
          dividerColor: mt(context).borderColor,
          titleTextColor: mt(context).text.primaryColor,
          trailingTextColor: mt(context).text.secondaryColor,

        ),
        platform: DevicePlatform.iOS,
        sections: [
          SettingsSection(
            title: const Text('GENERAL'),
            tiles: <SettingsTile>[

              SettingsTile.navigation(
                title: const Text("test"),
                value: const Text("welp"),
                leading: const Icon(Icons.telegram_sharp),
                onPressed: (context) {},
              )
            ],
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
            title: const Text('UNITS & LOCALIZATION'),
            tiles: <SettingsTile>[

              SettingsTile.navigation(
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                value: const Text('English'),
              ),

              SettingsTile.navigation(
                title: const Text('Weight'),
                value: const Text('Metric'),
              ),

              SettingsTile.navigation(
                title: const Text('Distance'),
                value: const Text('Imperial'),
              ),


            ]
          ),
          SettingsSection(
              title: const Text('DATA'),
              tiles: <SettingsTile>[

                SettingsTile.navigation(
                  leading: Icon(Icons.add_box_outlined),
                  title: const Text('Import'),
                  onPressed: (context) {

                  },
                ),

                SettingsTile.navigation(
                  leading: Icon(Icons.open_in_new),
                  title: const Text('Export'),
                  onPressed: (context) {

                  },
                ),

              ]
          ),
          SettingsSection(
            title: const Text('ABOUT'),
            tiles: <SettingsTile>[

              SettingsTile.navigation(
                leading: Icon(Icons.help_outline_rounded),
                title: const Text('Help'),
                onPressed: (context) {

                },
              ),

              SettingsTile.navigation(
                title: const Text('Feedback'),
                onPressed: (context) {

                },
              ),

              SettingsTile.navigation(
                title: const Text('Open source libraries'),
                onPressed: (context) {

                },
              ),

              SettingsTile(
                title: const Text('Version'),
                value: const Text('v1.0.0 android'),
                onPressed: (context) {

                },
              ),
            ]
          )
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
