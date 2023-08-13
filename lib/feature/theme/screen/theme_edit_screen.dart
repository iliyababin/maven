import 'package:flutter/material.dart';
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
      color: AppThemeColor.empty(),
    ),
  );

  Map<String, Color> colors = const AppThemeColor.empty().colors;


  @override
  void initState() {
    if(widget.theme != null) {
      theme = widget.theme!.copyWith(
        option: AppThemeOption(
          color: widget.theme!.option.color.copyWith().setColors(widget.theme!.option.color.colors),
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
          IconButton(
            onPressed: () {
              Navigator.pop(
                context,
                theme.copyWith(
                  option: AppThemeOption(

                    color: theme.option.color.setColors(colors),
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
