import 'package:flutter/material.dart';
import 'package:maven/feature/setting/screen/setting_screen.dart';

import '../../../common/widget/titled_scaffold.dart';
import '../../../generated/l10n.dart';
import '../../../theme/widget/inherited_theme_widget.dart';
import '../../equipment/screen/equipment_screen.dart';
import '../../exercise/screen/exercise_selection_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Profile',
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(T(context).padding.page),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                    minRadius: 25,
                    child: Text('A'),
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: InheritedThemeWidget.of(context).theme.options.textStyle.headingMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Weight Lifiting',
                      style: InheritedThemeWidget.of(context).theme.options.textStyle.subtitle1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            visualDensity: VisualDensity.compact,
            title: Text(
              'Basic',
              style: T(context).textStyle.titleMedium,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ExerciseSelectionScreen(
                            selection: false,
                          )));
            },
            leading: const Icon(
              Icons.sports_gymnastics,
            ),
            title: Text(S.current.exercises),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EquipmentScreen(),
                ),
              );
            },
            leading: const Icon(
              Icons.home_repair_service_rounded,
            ),
            title: const Text(
              'Equipment',
            ),
          ),
          ListTile(
            onTap: () {
              // TODO: Add measureing feature
            },
            leading: const Icon(
              Icons.straighten,
            ),
            title: const Text(
              'Measure',
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingScreen(),
                ),
              );
            },
            leading: const Icon(
              Icons.settings,
            ),
            title: const Text(
              'Settings',
            ),
          ),
        ],
      ),
    );
  }
}
