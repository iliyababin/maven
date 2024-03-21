import '../../../database/database.dart';
import '../transfer.dart';


 class ExerciseConversion {
  const ExerciseConversion({
    required this.source,
    required this.name,
  });

  final TransferSource source;
  final String name;
}