import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

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
                child: BlocBuilder<SettingBloc, SettingState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return Shimmer.fromColors(
                        baseColor: T(context).color.surface.baseShimmer,
                        highlightColor: T(context).color.surface.highlightShimmer,
                        child: Row(
                          children: [
                            CircleAvatar(
                              minRadius: 25,
                              child: Text(state.username[0]),
                            ),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    color: T(context).color.background,
                                    borderRadius: BorderRadius.circular(T(context).shape.small),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: T(context).color.background,
                                    borderRadius: BorderRadius.circular(T(context).shape.small),
                                  ),
                                  height: 20,
                                  width: 100,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else if (state.status.isLoaded) {
                      return Row(
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
                                state.username,
                                style: T(context).textStyle.headingMedium,
                              ),
                              Text(
                                state.description,
                                style: T(context).textStyle.bodyMedium,
                              ),
                            ],
                          )
                        ],
                      );
                    } else {
                      return const SizedBox(
                        child: Center(
                          child: Text('Error'),
                        ),
                      );
                    }
                  },
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
