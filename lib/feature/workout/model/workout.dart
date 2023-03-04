import 'package:floor/floor.dart';

import '../../template/model/template.dart';

@Entity(tableName: 'workout')
class Workout {

  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'workout_id')
  int? workoutId;

  @ColumnInfo(name: 'name')
  String name;

  @ColumnInfo(name: 'is_paused')
  int isPaused;
  
  @ColumnInfo(name: 'timestamp')
  DateTime timestamp;

  Workout({
    this.workoutId,
    required this.name,
    required this.isPaused,
    required this.timestamp,
  });

  static Workout fromTemplate(Template template){
    return Workout(
      name: template.name,
      isPaused: 0,
      timestamp: DateTime.now(),
    );
  }

  Workout copyWith({
    int? workoutId,
    String? name,
    int? isPaused,
    DateTime? timestamp,
  }) {
    return Workout(
      workoutId: workoutId ?? this.workoutId,
      name: name ?? this.name,
      isPaused: isPaused ?? this.isPaused,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}