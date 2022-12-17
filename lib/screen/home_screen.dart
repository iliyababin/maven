import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

import '../data/app_themes.dart';
import '../widget/titled_section.dart';

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
                backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
            ),
            onPressed: () {
              ThemeProvider.controllerOf(context).setTheme("light_theme");
            },
            child: Text("swotch"),
          )
        ),
        TitledSection(
            title: "Testing",
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor)
              ),
              onPressed: () {
                ThemeProvider.controllerOf(context).setTheme("dark_theme");
              },
              child: Text("test"),
            )
        ),
      ],
    );
  }
}
