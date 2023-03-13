import 'dart:math';

import '../model/plate.dart';

class EquipmentService {

  static List<Plate> getPlatesFromWeight(List<Plate> providedPlates, double weight) {

    List<Plate> plates = [];


    for(int i = 0; i < providedPlates.length; i++) {
      Plate plate = providedPlates[i];

      if(plate.amount == 0) continue;

      int calculated = (weight / plate.weight).truncate();

      for(int j = 0; j < [calculated, plate.amount].reduce(min); j++) {
        plates.add(plate);
        weight -= plate.weight;
      }

      if(weight == 0) break;
    }

    return plates;
  }
}