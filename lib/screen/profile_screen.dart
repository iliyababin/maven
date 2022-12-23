import 'package:flutter/material.dart';

import '../common/model/exercise_set.dart';
import '../util/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          List<ExerciseSet> test =
              await DatabaseHelper.instance.getExerciseSets();
          print(test.length);
        },
        child: Text("exerciseSets"));
  }
}
