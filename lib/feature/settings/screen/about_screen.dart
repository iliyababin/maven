import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../settings.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final PackageInfo packageInfo = state.packageInfo!;
            return ListView(
              children: [
                ListTile(
                  title: const Text('Name'),
                  subtitle: Text(packageInfo.appName),
                ),
                ListTile(
                  title: const Text('Version'),
                  subtitle: Text(packageInfo.version),
                ),
                ListTile(
                  title: const Text('Build Number'),
                  subtitle: Text(packageInfo.buildNumber),
                ),
                ListTile(
                  onTap: () {
                    // Add Licenses
                  },
                  title: const Text('Open Source Licenses'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
