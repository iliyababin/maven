
import '../dao/plate_dao.dart';
import '../model/plate.dart';

Future<List<Plate>> getPlatesFromWeight(PlateDao plateDao, double weight) async {
  List<Plate> providedPlates = await plateDao.getPlates();

  List<Plate> plates = [];

  for(int i = 0; i < providedPlates.length; i++) {
    Plate plate = providedPlates[i];

    int calculated = (weight / plate.weightLb).truncate();

    for(int j = 0; j < calculated; j++) {
      plates.add(plate);
      weight -= plate.weightLb;
    }

    if(weight == 0) break;
  }

  return plates;
}