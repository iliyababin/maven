import 'package:Maven/common/widget/m_button.dart';
import 'package:Maven/common/widget/titled_scaffold.dart';
import 'package:Maven/theme/m_themes.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../exercise/screen/exercise_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return TitledScaffold(
      title: 'Dashboard',
      body: Padding(
        padding: EdgeInsets.all(mt(context).padding.page),
        child: ListView(
          children: [
            MButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ExerciseSelectionScreen(
                  selection: false,
                )));
              },
              expand: false,
              leading: const Icon(Icons.sports_gymnastics),
              borderColor: mt(context).color.secondary,
              child: Text(
                S.current.exercises,
                style: mt(context).textStyle.body1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
