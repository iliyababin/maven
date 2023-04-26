import 'package:floor/floor.dart';

@Entity(tableName: 'workout')
class Workout {
  Workout({
    this.workoutId,
    required this.name,
    required this.isActive,
    required this.timestamp,
  });
  
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'workout_id')
  int? workoutId;

  @ColumnInfo(name: 'name')
  String name;

  @ColumnInfo(name: 'is_active')
  bool isActive;
  
  @ColumnInfo(name: 'timestamp')
  DateTime timestamp;
  
  Workout copyWith({
    int? workoutId,
    String? name,
    bool? isActive,
    DateTime? timestamp,
  }) {
    return Workout(
      workoutId: workoutId ?? this.workoutId,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}