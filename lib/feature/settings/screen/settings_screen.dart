import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/transfer/screen/transfer_import_export_screen.dart';

import '../../../common/common.dart';
import '../../../database/database.dart';
import '../../theme/theme.dart';
import '../settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  Widget Panel(BuildContext context, Widget child) {
    return SliverToBoxAdapter(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          T(context).shape.large,
        ),
        child: Material(
          color: T(context).color.surface,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            Settings setting = state.settings!;
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: T(context).space.large,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: T(context).space.large,
                    ),
                  ),
                  Panel(
                    context,
                    Column(
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.fitness_center_outlined),
                          title: const Text('Routine'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.calculate_outlined),
                          title: const Text('Plate Calculator'),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: T(context).space.large,
                    ),
                  ),
                  Panel(
                    context,
                    Column(
                      children: [
                        ListTile(
                          onTap: () {
                            showBottomSheetDialog(
                              context: context,
                              child: ListDialog(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      context.read<SettingsBloc>().add(
                                            SettingsUpdate(
                                              InheritedSettingsWidget.of(context).settings.copyWith(
                                                    unit: Unit.metric,
                                                  ),
                                            ),
                                          );
                                    },
                                    title: const Text('Metric'),
                                    trailing: const Text('kg/km/m/cm'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      context.read<SettingsBloc>().add(
                                            SettingsUpdate(
                                              InheritedSettingsWidget.of(context).settings.copyWith(
                                                    unit: Unit.imperial,
                                                  ),
                                            ),
                                          );
                                    },
                                    title: const Text('Imperial'),
                                    trailing: const Text('lb/mile/ft/in'),
                                  ),
                                ],
                              ),
                            );
                          },
                          leading: const Icon(Icons.straighten_outlined),
                          title: const Text('Units'),
                          trailing: Text(setting.unit.name),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const ThemeScreen()));
                          },
                          leading: const Icon(Icons.palette),
                          title: const Text('Theme'),
                          trailing: Text(InheritedThemeWidget.of(context).theme.name),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.volume_up_outlined),
                          title: const Text('Sound'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.notifications_none_outlined),
                          title: const Text('Notifications'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const LanguageScreen()));
                          },
                          leading: const Icon(Icons.language),
                          title: const Text('Language'),
                          trailing: Text(s(context).locale.languageCode.capitalize),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: T(context).space.large,
                    ),
                  ),
                  Panel(
                    context,
                    Column(
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.backup),
                          title: const Text('Backup'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TransferImportExportScreen(),
                              ),
                            );
                          },
                          leading: const Icon(
                            Icons.open_in_new_outlined,
                          ),
                          title: const Text(
                            'Export & Import',
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: T(context).space.large,
                    ),
                  ),
                  Panel(
                    context,
                    Column(
                      children: [
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.help_outline_outlined),
                          title: const Text('Help'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.feedback_outlined),
                          title: const Text('Feedback'),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutScreen(),
                              ),
                            );
                          },
                          leading: const Icon(Icons.info_outline),
                          title: const Text('About'),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: T(context).space.large,
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
