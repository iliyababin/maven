import 'package:maven/common/common.dart';

enum Muscle {
  adductors,
  bicepsBrachii,
  brachialis,
  brachioradialis,
  deltoid,
  deepHipExternalRotators,
  erectorSpinae,
  gastrocnemius,
  gluteus,
  gracilis,
  hamstrings,
  iliopsoas,
  infraspinatus,
  latissimusDorsi,
  levatorScapulae,
  obliques,
  pectineous,
  pectoralisMajor,
  pectoralisMinor,
  popliteus,
  quadratusLumborum,
  quadriceps,
  rectusAbdominis,
  rhomboids,
  sartorius,
  serratusAnterior,
  soleus,
  splenius,
  sternocleidomastoid,
  subscapularis,
  supraspinatus,
  tensorFasciaeLatae,
  teres,
  tibialisAnterior,
  transverseAbdominus,
  trapezius,
  tricepsBrachii,
  wrist,
  fullBody,
  none;

  String get name {
    String muscleString = toString().split('.').last;
    return muscleString.replaceAllMapped(
      RegExp(
        r'(?<=[a-z])([A-Z])',
      ),
          (match) => ' ${match.group(1)}',
    ).toLowerCase().capitalize;
  }
}
