import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../generated/l10n.dart';
import '../../theme/theme.dart';
import '../../equipment/equipment.dart';
import '../../exercise/exercise.dart';
import '../../settings/settings.dart';
import '../../user/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Profile',
      slivers: [
        const Heading(
          title: 'Account',
          size: HeadingSize.small,
        ),
        const SliverToBoxAdapter(
          child: UserWidget(),
        ),
        const Heading(
          title: 'Basic',
        ),
        SliverToBoxAdapter(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Material(
              color: T(context).color.surface,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExerciseSelectionScreen(
                            selection: false,
                          ),
                        ),
                      );
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
                          builder: (context) => const SettingsScreen(),
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
            ),
          ),
        ),
      ],
    );
  }
}
