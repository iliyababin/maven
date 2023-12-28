import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../common/common.dart';
import '../theme.dart';

class ThemeEditScreen extends StatefulWidget {
  const ThemeEditScreen({
    super.key,
    this.theme,
  });

  final AppTheme? theme;

  @override
  State<ThemeEditScreen> createState() => _ThemeEditScreenState();
}

class _ThemeEditScreenState extends State<ThemeEditScreen> {
  AppTheme theme = const AppTheme(
    name: 'Custom',
    brightness: Brightness.light,
    option: AppThemeOption(
      color: AppThemeColor.dark(),
    ),
  );

  Map<String, Color> colors = const AppThemeColor.dark().colors;

  @override
  void initState() {
    if (widget.theme != null) {
      theme = widget.theme!.copyWith(
        option: AppThemeOption(
          color: const AppThemeColor.dark().copyWith()
              .setColors(widget.theme!.option.color.colors),
        ),
      );
      colors = theme.option.color.colors;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.theme == null ? 'Create' : 'Edit',
        ),
        actions: [
          if (widget.theme != null)
            IconButton(
              onPressed: () {
                showBottomSheetDialog(
                  context: context,
                  child: ListDialog(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          context.read<ThemeBloc>().add(ThemeAdd(
                                theme: AppTheme(
                                  brightness: theme.brightness,
                                  name: '${theme.name} - Copy',
                                  option: AppThemeOption(
                                    color: theme.option.color,
                                  ),
                                ),
                              ));
                        },
                        leading: const Icon(
                          Icons.copy_outlined,
                        ),
                        title: const Text(
                          'Duplicate',
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          // TODO: share theme
                        },
                        leading: const Icon(
                          Icons.share_rounded,
                        ),
                        title: const Text(
                          'Share',
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          if (widget.theme!.id ==
                              InheritedThemeWidget.of(context).theme.id) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Cannot delete current theme',
                                ),
                              ),
                            );
                          } else {
                            context.read<ThemeBloc>().add(ThemeDelete(
                                  theme: theme,
                                ));
                          }
                        },
                        leading: Icon(
                          Icons.delete_rounded,
                          color: T(context).color.error,
                        ),
                        title: Text(
                          'Delete',
                          style: TextStyle(
                            color: T(context).color.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.more_vert_rounded),
            ),
          IconButton(
            onPressed: () {
              AppThemeColor theme2 = AppThemeColor.dark().copyWith(
                      /*id: widget.theme!.option.color.id,
                appThemeId: widget.theme!.option.color.appThemeId,*/
                      )
                  .setColors(colors);
              Navigator.pop(
                context,
                theme.copyWith(
                  option: AppThemeOption(
                    color: theme2,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.check_rounded,
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(
              T(context).space.large,
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
                        onTap: () {
                          showBottomSheetDialog(
                            context: context,
                            child: TextInputDialog(
                              title: 'Name',
                              initialValue: theme.name,
                              keyboardType: TextInputType.name,
                              onValueSubmit: (value) {
                                setState(() {
                                  theme = theme.copyWith(
                                    name: value,
                                  );
                                });
                              },
                            ),
                          );
                        },
                        title: const Text(
                          'Name',
                        ),
                        trailing: Text(
                          theme.name,
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Brightness',
                        ),
                        subtitle: Text(
                          theme.brightness.name.capitalize,
                        ),
                        trailing: Switch(
                          value: theme.brightness == Brightness.light,
                          onChanged: (value) {
                            setState(() {
                              theme = theme.copyWith(
                                brightness:
                                    value ? Brightness.light : Brightness.dark,
                              );
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: colors.length,
              (context, index) {
                String name = colors.keys.elementAt(index);
                Color color = colors.values.elementAt(index);
                return ListTile(
                  onTap: () {
                    showBottomSheetDialog(
                      context: context,
                      child: ColorPicker(
                        hexInputBar: true,
                        enableAlpha: false,
                        colorPickerWidth: 500,
                        pickerAreaHeightPercent: 0.4,
                        pickerColor: color,
                        labelTypes: const [],
                        onColorChanged: (value) {
                          setState(() {
                            colors[name] = value;
                          });
                        },
                      ),
                    );
                  },
                  leading: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: color,
                    ),
                  ),
                  title: Text(
                    name,
                    style: T(context).textStyle.bodyLarge,
                  ),
                  subtitle: Text(
                    color.value
                        .toRadixString(16)
                        .substring(
                          2,
                        )
                        .toUpperCase(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
