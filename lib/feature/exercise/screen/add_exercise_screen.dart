import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/model/exercise.dart';
import '../../template/dao/exercise_dao.dart';

class AddExerciseScreen extends StatelessWidget {
  const AddExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercises"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async{
              List<Exercise> help  = await context.read<ExerciseDao>().getExercises();

              print(help.first.name);
            }, child: Text("get first exercise"),
          ),
          Flexible(
            fit: FlexFit.tight,
          child: FutureBuilder<List<Exercise>>(
            future: context.read<ExerciseDao>().getExercises(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading..s.'));
              }
              return ListView(
                children: snapshot.data!.map((exercise) {
                  return ListTile(
                    onTap: () {
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
