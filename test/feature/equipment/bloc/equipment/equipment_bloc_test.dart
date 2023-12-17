import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maven/database/database.dart';
import 'package:maven/feature/equipment/equipment.dart';
import 'package:mockito/mockito.dart';

class MockPlateDao extends Mock implements PlateDao {
  Stream<List<Plate>> getPlatesAsStream() {
    return Stream.empty();
  }
}

class MockBarDao extends Mock implements BarDao {
  Stream<List<Bar>> getBarsAsStream() {
    return Stream.empty();
  }
}

void main() {
  group('EquipmentBloc', () {
    late MockPlateDao mockPlateDao;
    late MockBarDao mockBarDao;

    setUp(() {
      mockPlateDao = MockPlateDao();
      mockBarDao = MockBarDao();
    });

    blocTest('idk',
      build: () => EquipmentBloc(
        plateDao: mockPlateDao,
        barDao: mockBarDao,
      ),

    );
  });
}


