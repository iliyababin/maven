import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/common.dart';

import '../../../database/database.dart';
import '../../../l10n/screen/language_screen.dart';
import '../../../theme/theme.dart';
import '../setting.dart';

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
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if(state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status.isLoaded) {
            return ListView(
              children: [
                ListTile(
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    'Appearance',
                    style: T(context).textStyle.titleMedium,
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
                  trailing: Text(
                    state.setting!.theme.name,
                  ),
                ),
                ListTile(
                  onTap: () {
                    WeightUnit weightUnit = s(context).weightUnit == WeightUnit.kgs ? WeightUnit.lbs : WeightUnit.kgs;
                    InheritedSettingWidget.of(context).setWeightUnit(weightUnit);
                  },
                  leading: const Icon(
                    Icons.tag,
                  ),
                  title: const Text(
                    'Units',
                  ),
                  trailing: Text(
                    s(context).weightUnit.name,
                  )
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
                  trailing: Text(
                    s(context).locale.languageCode.capitalize,
                  )
                ),
                ListTile(
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    'Help',
                    style: T(context).textStyle.titleMedium,
                  ),
                ),
                ListTile(
                  onTap: () {

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
            );
          } else {
            return const Center(
              child: Text(
                'Error',
              ),
            );
          }
        },
      ),
    );
  }
}
