import 'package:flutter/material.dart';
import 'package:maven/widgets/titled_section.dart';
import 'package:stacked_themes/stacked_themes.dart';

import '../data/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitledSection(
          title: "Testing",
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: getErrorColor(context)
            ),
            onPressed: () {
              getThemeManager(context).selectThemeAtIndex(0);
            },
            child: Text("swotch"),
          )
        ),
        TitledSection(
            title: "Testing",
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: getErrorColor(context)
              ),
              onPressed: () {
                getThemeManager(context).selectThemeAtIndex(1);
              },
              child: Text("test"),
            )
        )
      ],
    );
  }
}
