import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../settings/settings.dart';
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
          'Theme',
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const Heading(
            title: 'General',
            side: true,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: T(context).space.large,
            ),
            sliver: SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  T(context).shape.large,
                ),
                child: Material(
                  color: T(context).color.surface,
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text(
                          'System Default',
                        ),
                        trailing: Switch(
                          value: s(context).useSystemDefaultTheme,
                          onChanged: (value) {
                            context.read<SettingsBloc>().add(SettingsUpdate(
                                  InheritedSettingsWidget.of(context).settings.copyWith(
                                        useSystemDefaultTheme: value,
                                        useDynamicColor: value ? s(context).useDynamicColor : false,
                                      ),
                                ));
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Dynamic Color',
                        ),
                        subtitle: const Text(
                          'Beta',
                        ),
                        trailing: Switch(
                          value: s(context).useDynamicColor,
                          onChanged: (value) {
                            context.read<SettingsBloc>().add(SettingsUpdate(
                                  InheritedSettingsWidget.of(context).settings.copyWith(
                                        useSystemDefaultTheme:
                                            value ? true : s(context).useSystemDefaultTheme,
                                        useDynamicColor: value,
                                      ),
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Heading(
            title: 'Themes',
            side: true,
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
                      context.read<ThemeBloc>().add(
                            ThemeAdd(
                              theme: value,
                            ),
                          );
                    }
                  });
                },
                icon: const Icon(
                  Icons.add_rounded,
                ),
              ),
            ],
          ),
          !s(context).useSystemDefaultTheme
              ? BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    if (state.status.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      AppTheme activeTheme = state.theme;
                      List<AppTheme> themes = state.themes;
                      return SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: T(context).space.large,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              T(context).shape.large,
                            ),
                            child: Material(
                              color: T(context).color.surface,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: themes.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  AppTheme theme = themes[index];
                                  return ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ThemeEditScreen(
                                            theme: theme,
                                          ),
                                        ),
                                      ).then((value) {
                                        if (value != null) {
                                          AppTheme theme = value;
                                          context
                                              .read<ThemeBloc>()
                                              .add(ThemeUpdate(
                                                theme: value,
                                              ));
                                        }
                                      });
                                    },
                                    leading: CircleAvatar(
                                        backgroundColor:
                                            theme.option.color.background,
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
                                        context
                                            .read<ThemeBloc>()
                                            .add(ThemeChange(
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
                      );
                    }
                  },
                )
              : SliverBoxWidget(
                  side: true,
                  text: 'Disabled. System theme is used.',
                ),
        ],
      ),
    );
  }
}
