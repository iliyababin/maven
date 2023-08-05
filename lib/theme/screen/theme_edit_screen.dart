import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:maven/common/dialog/dialog.dart';
import 'package:maven/theme/data/app_theme_data.dart';

import '../theme.dart';

class ThemeEditScreen extends StatefulWidget {
  const ThemeEditScreen({
    super.key,
  });

  @override
  State<ThemeEditScreen> createState() => _ThemeEditScreenState();
}

class _ThemeEditScreenState extends State<ThemeEditScreen> {
  AppTheme theme = AppTheme(
    name: 'Custom',
    brightness: Brightness.light,
    options: ThemeOptions(color: getDefaultAppThemes.first),
    path: 'null',
  );

  Map<String, Color> colors = getDefaultAppThemes.first.colors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                theme.copyWith(
                  options: ThemeOptions(
                    color: theme.options.color.setColors(colors),
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
      body: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (context, index) {
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
          );
        },
      ),
    );
  }
}
