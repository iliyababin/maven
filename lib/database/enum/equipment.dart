
import 'package:maven/common/common.dart';

enum Equipment {
  assisted,
  ball,
  band,
  barbell,
  bench,
  bodyWeight,
  cable,
  dumbbell,
  kettleBell,
  machine,
  none,
  plate,
  rope,
  stretch,
  trapBar,
  weighted,
  wheelRoller;

  String get name {
    return toString().split('.').last.capitalize;
  }
}

extension EquipmentExtension on Equipment {
  int get equipmentId {
    return index + 1;
  }

  String get description {
    switch (this) {
      case Equipment.assisted:
        return 'An assisted exercise machine provides support to the user during the exercise, allowing them to perform the movement with less resistance.';
      case Equipment.ball:
        return 'A ball is a large, inflatable ball that can be used for resistance training.';
      case Equipment.band:
        return 'A band is a long, thin piece of elastic material that can be used for resistance training.';
      case Equipment.barbell:
        return 'A barbell is a long bar with weight plates attached to either end, used for weight training.';
      case Equipment.bench:
        return 'A bench is a piece of equipment designed to support the user during exercises, typically used for weight training.';
      case Equipment.trapBar:
        return 'A trap-bar is a hexagonal shaped bar with weight plates attached to either end, used for weight training.';
      case Equipment.bodyWeight:
        return 'Body-weight exercises use the weight of the individuals own body as resistance, rather than using external weights or machines.';
      case Equipment.cable:
        return 'A cable machine uses adjustable cable pulleys to provide resistance and allow for a wide variety of exercises.';
      case Equipment.dumbbell:
        return 'Dumbbells are small, handheld weights that can be used for various exercises.';
      case Equipment.kettleBell:
        return 'A kettle-bell is a cast iron weight shaped like a ball with a handle, used for exercises that combine cardiovascular, strength, and flexibility training.';
      case Equipment.plate:
        return 'A plate is a flat, circular weight that can be used for various exercises.';
      case Equipment.machine:
        return 'A machine is a piece of equipment designed to allow the user to perform one or more specific exercises, typically with adjustable resistance.';
      case Equipment.none:
        return 'None refers to exercises that do not require any equipment.';
      case Equipment.rope:
        return 'A rope is a long, thick piece of material that can be used for resistance training.';
      case Equipment.stretch:
        return 'Stretch exercises involve using the bodys flexibility to improve range of motion and reduce muscle tension.';
      case Equipment.weighted:
        return 'Weighted exercises involve using external weights, such as dumbbells or a barbell, to increase the resistance of the exercise.';
      case Equipment.wheelRoller:
        return 'A wheel-roller is a small wheel with a handle on either side, used for exercises that combine cardiovascular, strength, and flexibility training.';
    }
  }
}

Equipment? getEquipmentById(int id) {
  for (Equipment equipment in Equipment.values) {
    if (equipment.equipmentId == id) {
      return equipment;
    }
  }
  return null;
}