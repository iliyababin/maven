import 'package:floor/floor.dart';

enum ExerciseType {
  weightAndReps,
  duration,
}

@Entity(tableName: 'exercise')
class Exercise {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'exercise_id')
  final int exerciseId;

  @ColumnInfo(name: 'name')
  final String name;

  @ColumnInfo(name: 'muscle')
  final String muscle;

  @ColumnInfo(name: 'picture')
  final String picture;

  const Exercise({
    required this.exerciseId,
    required this.name,
    required this.muscle,
    required this.picture,
  });

  factory Exercise.fromMap(Map<String, dynamic> json) => Exercise(
    exerciseId: json["exerciseId"],
    name: json["name"],
    muscle: json["muscle"],
    picture: json["picture"],
  );

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'name': name,
      'muscle': muscle,
      'picture': picture,
    };
  }
}


