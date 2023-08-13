import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maven/feature/theme/widget/inherited_theme_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';
import '../theme.dart';
import '../../settings/settings.dart';

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
          'Appearance',
        ),
      ),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            AppTheme activeTheme = state.theme;
            List<AppTheme> themes = state.themes;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: T(context).space.large,
              ),
              child: CustomScrollView(
                slivers: [
                  const Heading(
                    title: 'General',
                    size: HeadingSize.medium,
                  ),
                  SliverToBoxAdapter(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(T(context).shape.large),
                      child: Material(
                        color: T(context).color.surface,
                        child: ListTile(
                          title: const Text(
                            'System Default',
                          ),
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {
                              // Tpdp"
                            },
                          ),
                        )
                      ),
                    ),
                  ),
                  Heading(
                    title: 'Themes',
                    actions: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ThemeEditScreen(),
                            ),
                          ).then((value) {
                            if (value != null) {
                              context.read<ThemeBloc>().add(ThemeAdd(
                                theme: value,
                              ));
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.add_rounded,
                        ),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(T(context).shape.large),
                      child: Material(
                        color: T(context).color.surface,
                        child: ListView.builder(
                          itemCount: themes.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            AppTheme theme = themes[index];

                            return ListTile(
                              onTap: () {
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ThemeEditScreen(
                                      theme: theme,
                                    ),
                                  ),
                                ).then((value) {
                                  if (value != null) {
                                    InheritedSettingWidget.of(context).updateTheme(value);
                                  }
                                });*/
                              },
                              leading: CircleAvatar(
                                  backgroundColor: theme.option.color.background,
                                  child: Text(
                                    theme.name[0].capitalize,
                                    style: TextStyle(
                                      color: theme.option.color.primary,
                                    ),
                                  )),
                              title: Text(
                                theme.name,
                              ),
                              subtitle: Text(
                                theme.data.brightness.name.capitalize,
                              ),
                              trailing: Radio(
                                value: theme.id,
                                groupValue: activeTheme.id,
                                onChanged: (value) {
                                  context.read<ThemeBloc>().add(ThemeChange(
                                    theme: theme,
                                  ));
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const Heading(
                    title: 'Other',
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
