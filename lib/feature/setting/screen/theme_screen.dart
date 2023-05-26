
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/m_themes.dart';
import '../../../theme/maven_theme.dart';
import '../bloc/setting_bloc.dart';

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
        padding: EdgeInsets.all(mt(context).padding.page),
        child: BlocBuilder<SettingBloc, SettingState>(
          builder: (context, state) {
            final List<MavenTheme> themes = state.themes;
            final String selectedThemeId = state.theme.id;

            return GridView.builder(
              itemCount: themes.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 8,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                print(index);
                final MavenTheme theme = themes[index];

                return GestureDetector(
                  onTap: () {
                    context.read<SettingBloc>().add(SettingChangeTheme(
                      id: theme.id,
                    ),);
                  },
                  child: Container(
                    height: 1,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        width: 3,
                        color: selectedThemeId == theme.id ? mt(context).color.primary : Colors.transparent,
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
              },
            );
          },
        ),
      ),
    );
  }
}
