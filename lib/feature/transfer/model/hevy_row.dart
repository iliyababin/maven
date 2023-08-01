
import '../../../common/common.dart';
import '../transfer.dart';

class HevyRow extends CSVRow {
  HevyRow(List<dynamic> row) : super(
    date: row[0],
    workoutName: row[1],
    workoutDuration: Timed().toString(),
    exerciseName: row[3],
    duration: Timed.fromSeconds(row[8]).toString(),
    reps: row[5],
    weight: row[6],
    distance: row[7],
  );
}