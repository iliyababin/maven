import 'package:Maven/common/extension.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Language',
        ),
      ),
      body: ListView.builder(
        itemCount: S.delegate.supportedLocales.length,
        itemBuilder: (context, index) {
          Locale locale = S.delegate.supportedLocales[index];
          return ListTile(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();

              print(locale.toString());
              prefs.setString('language', locale.toString());
              S.delegate.load(locale);
              Navigator.pop(context);
            },
            tileColor: Localizations.localeOf(context) == locale
                ? Theme.of(context).colorScheme.secondary
                : null,
            title: Text(
              locale.languageCode.capitalize(),
            ),
          );
        },
      ),
    );
  }
}
