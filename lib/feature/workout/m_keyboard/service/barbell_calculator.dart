
import 'dart:math';

import '../dao/plate_dao.dart';
import '../model/plate.dart';

Future<List<Plate>> getPlatesFromWeight(PlateDao plateDao, double weight) async {
  List<Plate> providedPlates = await plateDao.getPlates();

  List<Plate> plates = [];

  weight = (weight - 45) / 2;

  for(int i = 0; i < providedPlates.length; i++) {
    Plate plate = providedPlates[i];

    int calculated = (weight / plate.weight).truncate();

    for(int j = 0; j < [calculated, plate.amount].reduce(min); j++) {
      plates.add(plate);
      weight -= plate.weight;
    }

    if(weight == 0) break;
  }

  return plates;
}