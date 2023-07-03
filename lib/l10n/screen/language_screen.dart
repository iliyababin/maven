import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/common/extension/extension.dart';
import 'package:maven/feature/setting/bloc/setting_bloc.dart';

import '../../generated/l10n.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Language',
        ),
      ),
      body: ListView.builder(
        itemCount: S.delegate.supportedLocales.length,
        itemBuilder: (context, index) {
          Locale locale = S.delegate.supportedLocales[index];
          return ListTile(
            onTap: () async {
              context.read<SettingBloc>().add(SettingChangeLocale(
                locale: locale,
              ));
            },
            tileColor: Localizations.localeOf(context) == locale
                ? Theme.of(context).colorScheme.secondary
                : null,
            title: Text(
              locale.languageCode.capitalize,
            ),
          );
        },
      ),
    );
  }
}
