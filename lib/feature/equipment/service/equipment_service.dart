import 'dart:math';

import 'package:flutter/material.dart';

import '../dao/plate_dao.dart';
import '../model/plate.dart';

class EquipmentService {
  EquipmentService({
    required PlateDao plateDao,
  }) : _plateDao = plateDao;

  final PlateDao _plateDao;

  Future<Plate> addEmptyPlate() async {
    int plateId = await _plateDao.addPlate(const Plate(
      amount: 0,
      color: Colors.pink,
      height: 1,
      isCustomized: false,
      weight: 0,
    ));
    Plate? plate = await _plateDao.getPlate(plateId);
    if(plate == null) throw Exception('A created plate could not be found in the database. This should never happen.');
    return plate;
  }

  Stream<List<Plate>> getPlatesStream() => _plateDao.getPlatesStream();

  Future<void> updatePlate(Plate plate) => _plateDao.updatePlate(plate);

  List<Plate> getPlatesFromWeight(List<Plate> providedPlates, double weight) {

    List<Plate> plates = [];

    weight = (weight - 45) / 2;

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