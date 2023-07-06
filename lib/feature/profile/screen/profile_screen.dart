import 'package:flutter/material.dart';

import '../../../common/common.dart';
import '../../../generated/l10n.dart';
import '../../../theme/theme.dart';
import '../../equipment/equipment.dart';
import '../../exercise/exercise.dart';
import '../../setting/setting.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Profile',
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: T(context).space.large),
        child: CustomScrollView(
          slivers: [
            const Heading(
              title: 'Account',
              size: HeadingSize.small,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(T(context).space.large),
                decoration: BoxDecoration(
                  color: T(context).color.surface,
                  borderRadius: BorderRadius.circular(T(context).shape.large),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement user avatar
                      },
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
                          s(context).username,
                          style: T(context).textStyle.headingMedium,
                        ),
                        Text(
                          s(context).description,
                          style: T(context).textStyle.bodyMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
