
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Theme',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(T(context).padding.page),
        child: GridView.builder(
          itemCount: AppTheme.themes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 8,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final AppTheme theme = AppTheme.themes[index];

            return GestureDetector(
              onTap: () {
                InheritedThemeWidget.of(context).setTheme(theme.id);
              },
              child: Container(
                height: 1,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    width: 3,
                    color: InheritedThemeWidget.of(context).theme.id == theme.id ? T(context).color.primary : Colors.transparent,
                  ),
                ),
                child: Stack(
                    children: [
                      SizedBox(
                        height: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            theme.path,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        left: 0,
                        bottom: 18,
                        child: Text(
                          theme.name,
                          textAlign: TextAlign.center,
                          style: T(context).textStyle.button1,
                        ),
                      ),
                    ]
                ),
              ),
            );
          },
        )
      ),
    );
  }
}
