
import '../../exercise/model/exercise.dart';
import 'day.dart';

class ExerciseDay {
  const ExerciseDay({
    required this.day,
    required this.exercises,
  });

  final Day day;
  final List<Exercise> exercises;
}

extension ExerciseDayListExtension on List<ExerciseDay> {
  String getAbbreviations() {
    List<String> abbreviations = map((exerciseDay) => exerciseDay.day.getAbbreviation()).toList();
    return abbreviations.join('/');
  }

  List<Day> getDays() {
    return map((exerciseDay) => exerciseDay.day).toList();
  }

  List<ExerciseDay> sortDays() {
    // Define a map to associate each Day with a numeric value
    Map<Day, int> dayOrder = {
      Day.sunday: 0,
      Day.monday: 1,
      Day.tuesday: 2,
      Day.wednesday: 3,
      Day.thursday: 4,
      Day.friday: 5,
      Day.saturday: 6,
    };

    // Sort the list of ExerciseDay objects by the numeric value of their Day
    sort((a, b) => dayOrder[a.day]! - dayOrder[b.day]!);

    return this; // Return the sorted list of ExerciseDay objects
  }
}