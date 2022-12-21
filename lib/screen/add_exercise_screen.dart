import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maven/common/model/exercise.dart';
import 'package:maven/util/database_helper.dart';
import 'package:maven/util/exercise_bloc.dart';

class AddExerciseScreen extends StatelessWidget {
  const AddExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exerciseBloc = ExerciseBloc();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercises"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async{


              List<Exercise> help  = await DatabaseHelper.instance.getExercises();

              print(help.first.name);
            }, child: Text("get first exercise"),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: StreamBuilder<List<Exercise>>(
              stream: exerciseBloc.exercises,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading..s.'));
                }
                return ListView(
                  children: snapshot.data!.map((exercise) {
                    return ListTile(
                      onTap: (){
                        Navigator.pop(context, exercise);
                      },
                      title: Text(exercise.name),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ]
      ),
      
    );
  }
}
