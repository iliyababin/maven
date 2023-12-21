import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../theme/theme.dart';
import '../settings.dart';

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
                context.read<SettingsBloc>().add(SettingsUpdate(
                      InheritedSettingsWidget.of(context).settings.copyWith(
                            locale: locale,
                          ),
                    ));
              },
              tileColor: Localizations.localeOf(context) == locale
                  ? T(context).color.primaryContainer
                  : null,
              title: Text(locale.toLanguageTag()),
              trailing: Localizations.localeOf(context) == locale ? const Icon(Icons.check) : null);
        },
      ),
    );
  }
}
