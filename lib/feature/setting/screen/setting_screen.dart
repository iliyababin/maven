import 'package:flutter/material.dart';

import '../../../l10n/screen/language_screen.dart';
import '../../../theme/theme.dart';
import 'theme_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            title: Text(
              'Appearance',
              style: T(context).textStyle.heading4,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ThemeScreen()));
            },
            leading: const Icon(
              Icons.palette,
            ),
            title: const Text(
              'Theme',
            ),
          ),
          ListTile(
            onTap: () {
              // TODO: Add units feature
            },
            leading: const Icon(
              Icons.tag,
            ),
            title: const Text(
              'Units',
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageScreen()));
            },
            leading: const Icon(
              Icons.language,
            ),
            title: const Text(
              'Language',
            ),
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            title: Text(
              'Help',
              style: T(context).textStyle.heading4,
            ),
          ),
          ListTile(
            onTap: () {
              // TODO: Add units feature
            },
            leading: const Icon(
              Icons.sticky_note_2_outlined,
            ),
            title: const Text(
              'Guide',
            ),
          ),
          ListTile(
            onTap: () {
              // TODO: Add units feature
            },
            leading: const Icon(
              Icons.support,
            ),
            title: const Text(
              'Support',
            ),
          ),
          ListTile(
            onTap: () {
              // TODO: Add units feature
            },
            leading: const Icon(
              Icons.info_outline,
            ),
            title: const Text(
              'About',
            ),
          ),
        ],
      ),
    );
  }
}
