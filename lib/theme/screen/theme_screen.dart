import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/common.dart';
import '../../feature/settings/settings.dart';
import '../theme.dart';

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
      body: BlocBuilder<SettingBloc, SettingState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<AppTheme> themes = state.setting!.themes;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: T(context).space.large,
              ),
              child: CustomScrollView(
                slivers: [
                  Heading(
                    title: 'General',
                    size: HeadingSize.medium,
                  ),
                  SliverToBoxAdapter(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(T(context).shape.large),
                      child: Material(
                        color: T(context).color.surface,
                        child: ListTile(
                          title: Text(
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
                              context.read<SettingBloc>().add(SettingAddTheme(theme: value));
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
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                
                              },
                              leading: CircleAvatar(
                                  backgroundColor: themes[index].options.color.background,
                                  child: Text(
                                    themes[index].name[0].capitalize,
                                    style: TextStyle(
                                      color: themes[index].options.color.primary,
                                    ),
                                  )),
                              title: Text(
                                themes[index].name,
                              ),
                              subtitle: Text(
                                themes[index].data.brightness.name.capitalize,
                              ),
                              trailing: Radio(
                                value: themes[index].id,
                                groupValue: s(context).theme.id,
                                onChanged: (value) {
                                  InheritedSettingWidget.of(context).setTheme(themes[index].id!);
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
