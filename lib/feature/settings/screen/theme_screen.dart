
import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../../../theme/m_themes.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {

  String selectedThemeId = '';

  @override
  Widget build(BuildContext context) {
    if(selectedThemeId.isEmpty) {
      selectedThemeId = ThemeProvider.themeOf(context).id;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Theme',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(mt(context).padding.page),
        child: GridView.builder(
          itemCount: ThemeProvider.controllerOf(context).allThemes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 8,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            AppTheme theme = ThemeProvider.controllerOf(context).allThemes[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedThemeId = theme.id;
                });

                ThemeProvider.controllerOf(context).setTheme(theme.id);
              },
              child: Container(
                height: 1,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    width: 3,
                    color: ThemeProvider.controllerOf(context).currentThemeId == theme.id ? mt(context).color.primary : Colors.transparent,
                  ),
                ),
                child: Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          theme.id,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      left: 0,
                      bottom: 18,
                      child: Text(
                        theme.description,
                        textAlign: TextAlign.center,
                        style: mt(context).textStyle.button1,
                      ),
                    ),
                  ]
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
