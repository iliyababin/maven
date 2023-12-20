import 'dart:math';

import '../../../database/database.dart';

/// Service for interacting with equipment in the database.
class EquipmentService {
  final PlateDao plateDao;
  final BarDao barDao;

  EquipmentService({
    required this.plateDao,
    required this.barDao,
  });

  /// Adds a plate to the database.
  ///
  /// Throws [Exception] if the plate already has an ID.
  Future<Plate> addPlate(Plate plate) async {
    if (plate.id != null) {
      throw Exception('Plate already has an ID');
    }

    int plateId = await plateDao.add(plate);

    return getPlate(plateId);
  }

  /// Gets a plate from the database.
  ///
  /// Throws [Exception] if the provided ID does not exist.
  Future<Plate> getPlate(int plateId) async {
    Plate? plate = await plateDao.get(plateId);

    if (plate == null) {
      throw Exception('Plate does not exist');
    }

    return plate;
  }

  /// Gets all plates from the database.
  Future<List<Plate>> getAllPlates() async {
    return await plateDao.getAll();
  }

  /// Updates a plate in the database.
  ///
  /// Throws [Exception] if the plate does not have an ID.
  /// Throws [Exception] if the plate does not exist.
  Future<Plate> updatePlate(Plate plate) async {
    if (plate.id == null) {
      throw Exception('Plate does not have an ID');
    }

    int rowsChanged = await plateDao.modify(plate);

    if (rowsChanged == 0) {
      throw Exception('Plate was not updated');
    }

    return getPlate(plate.id!);
  }

  /// Deletes a plate from the database.
  ///
  /// Throws [Exception] if the plate does not exist.
  Future<void> deletePlate(Plate plate) async {
    int rowsRemoved = await plateDao.remove(plate);

    if (rowsRemoved == 0) {
      throw Exception('Plate was not deleted');
    }
  }

  /// Resets the plates in the database to the default plates.
  ///
  /// Returns a list of the default plates.
  Future<List<Plate>> resetPlates() async {
    for (Plate plate in await getAllPlates()) {
      await plateDao.remove(plate);
    }

    await plateDao.addAll(getDefaultPlates());

    return await getAllPlates();
  }

  /// Returns a list of plates that can be used to make up the provided weight.
  static List<Plate> getPlatesByWeight(List<Plate> providedPlates, double weight) {
    List<Plate> plates = [];

    for (int i = 0; i < providedPlates.length; i++) {
      Plate plate = providedPlates[i];

      if (plate.amount == 0) continue;

      int calculated = (weight / plate.weight).truncate();

      for (int j = 0; j < [calculated, plate.amount].reduce(min); j++) {
        plates.add(plate);
        weight -= plate.weight;
      }

      if (weight == 0) break;
    }

    return plates;
  }

  /// Adds a bar to the database.
  ///
  /// Throws [Exception] if the bar already has an ID.
  Future<Bar> addBar(Bar bar) async {
    if (bar.id != null) {
      throw Exception('Bar already has an ID');
    }

    int barId = await barDao.add(bar);

    return getBar(barId);
  }

  /// Gets a bar from the database.
  ///
  /// Throws [Exception] if the provided ID does not exist.
  Future<Bar> getBar(int barId) async {
    Bar? bar = await barDao.get(barId);

    if (bar == null) {
      throw Exception('Bar does not exist');
    }

    return bar;
  }

  /// Gets all bars from the database.
  Future<List<Bar>> getAllBars() async {
    return await barDao.getAll();
  }

  /// Updates a bar in the database.
  ///
  /// Throws [Exception] if the bar does not have an ID.
  /// Throws [Exception] if the bar does not exist.
  Future<Bar> updateBar(Bar bar) async {
    if (bar.id == null) {
      throw Exception('Bar does not have an ID');
    }

    int rowsChanged = await barDao.modify(bar);

    if (rowsChanged == 0) {
      throw Exception('Bar was not updated');
    }

    return getBar(bar.id!);
  }

  /// Deletes a bar from the database.
  ///
  /// Throws [Exception] if the bar does not exist.
  Future<void> deleteBar(Bar bar) async {
    int rowsRemoved = await barDao.remove(bar);

    if (rowsRemoved == 0) {
      throw Exception('Bar was not deleted');
    }
  }

  /// Resets the bars in the database to the default bars.
  ///
  /// Returns a list of the default bars.
  Future<List<Bar>> resetBars() async {
    for (Bar bar in await getAllBars()) {
      await barDao.remove(bar);
    }

    await barDao.addAll(getDefaultBars());

    return await getAllBars();
  }
}
