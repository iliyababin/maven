import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maven/database/database.dart';
import 'package:maven/feature/equipment/equipment.dart';
import 'package:mocktail/mocktail.dart';

class MockPlateDao extends Mock implements PlateDao {}

class MockBarDao extends Mock implements BarDao {}

void main() {
  group('EquipmentService', () {
    late PlateDao plateDao;
    late BarDao barDao;

    setUp(() {
      plateDao = MockPlateDao();
      barDao = MockBarDao();
    });

    EquipmentService build() {
      return EquipmentService(
        plateDao: plateDao,
        barDao: barDao,
      );
    }

    group('plate', () {
      const plate = Plate(
        weight: 45,
        amount: 1,
        color: Colors.red,
        height: 1,
      );

      const plateFromDB = Plate(
        id: 1,
        weight: 45,
        amount: 1,
        color: Colors.red,
        height: 1,
      );

      test('addPlate', () async {
        when(() => plateDao.add(plate)).thenAnswer((_) async => 1);
        when(() => plateDao.get(1)).thenAnswer((_) async => plateFromDB);

        expect(await build().addPlate(plate), plateFromDB);
      });

      test('addPlate throws exception if plate has ID', () async {
        expect(() async => await build().addPlate(plateFromDB), throwsException);
      });

      test('getPlate', () async {
        when(() => plateDao.get(1)).thenAnswer((_) async => plateFromDB);

        expect(await build().getPlate(1), plateFromDB);
      });

      test('getPlate throws exception if plate does not exist', () async {
        when(() => plateDao.get(1)).thenAnswer((_) async => null);

        expect(() async => await build().getPlate(1), throwsException);
      });

      test('getAllPlates', () async {
        when(() => plateDao.getAll()).thenAnswer((_) async => [plateFromDB, plateFromDB]);

        expect(await build().getAllPlates(), [plateFromDB, plateFromDB]);
      });

      test('updatePlate', () async {
        when(() => plateDao.modify(plateFromDB)).thenAnswer((_) async => 1);
        when(() => plateDao.get(1)).thenAnswer((_) async => plateFromDB);

        expect(await build().updatePlate(plateFromDB), plateFromDB);
      });

      test('updatePlate throws exception if plate does not have ID', () async {
        expect(() async => await build().updatePlate(plate), throwsException);
      });

      test('updatePlate throws exception if plate was not updated', () async {
        when(() => plateDao.modify(plateFromDB)).thenAnswer((_) async => 0);

        expect(() async => await build().updatePlate(plateFromDB), throwsException);
      });

      test('deletePlate', () async {
        when(() => plateDao.remove(plateFromDB)).thenAnswer((_) async => 1);

        await build().deletePlate(plateFromDB);

        verify(() => plateDao.remove(plateFromDB)).called(1);
      });

      test('deletePlate throws exception if plate was not deleted', () async {
        when(() => plateDao.remove(plateFromDB)).thenAnswer((_) async => 0);

        expect(() async => await build().deletePlate(plateFromDB), throwsException);
      });

      test('resetPlates', () async {
        when(() => plateDao.getAll()).thenAnswer((_) async => [plateFromDB, plateFromDB]);
        when(() => plateDao.remove(plateFromDB)).thenAnswer((_) async => 1);
        when(() => plateDao.addAll(getDefaultPlates())).thenAnswer((_) async => [1, 2]);

        expect(await build().resetPlates(), [plateFromDB, plateFromDB]);

        verify(() => plateDao.remove(plateFromDB)).called(2);
        verify(() => plateDao.addAll(getDefaultPlates())).called(1);
      });

      // TODO: write more comprehensive tests for getPlatesByWeight
    });

    group('bar', () {
      const bar = Bar(
        name: 'bar',
        weight: 45,
      );

      const barFromDB = Bar(
        id: 1,
        name: 'bar',
        weight: 45,
      );

      test('addBar', () async {
        when(() => barDao.add(bar)).thenAnswer((_) async => 1);
        when(() => barDao.get(1)).thenAnswer((_) async => barFromDB);

        expect(await build().addBar(bar), barFromDB);
      });

      test('addBar throws exception if bar has ID', () async {
        expect(() async => await build().addBar(barFromDB), throwsException);
      });

      test('getBar', () async {
        when(() => barDao.get(1)).thenAnswer((_) async => barFromDB);

        expect(await build().getBar(1), barFromDB);
      });

      test('getBar throws exception if bar does not exist', () async {
        when(() => barDao.get(1)).thenAnswer((_) async => null);

        expect(() async => await build().getBar(1), throwsException);
      });

      test('getAllBars', () async {
        when(() => barDao.getAll()).thenAnswer((_) async => [barFromDB, barFromDB]);

        expect(await build().getAllBars(), [barFromDB, barFromDB]);
      });

      test('updateBar', () async {
        when(() => barDao.modify(barFromDB)).thenAnswer((_) async => 1);
        when(() => barDao.get(1)).thenAnswer((_) async => barFromDB);

        expect(await build().updateBar(barFromDB), barFromDB);
      });

      test('updateBar throws exception if bar does not have ID', () async {
        expect(() async => await build().updateBar(bar), throwsException);
      });

      test('updateBar throws exception if bar was not updated', () async {
        when(() => barDao.modify(barFromDB)).thenAnswer((_) async => 0);

        expect(() async => await build().updateBar(barFromDB), throwsException);
      });

      test('deleteBar', () async {
        when(() => barDao.remove(barFromDB)).thenAnswer((_) async => 1);

        await build().deleteBar(barFromDB);

        verify(() => barDao.remove(barFromDB)).called(1);
      });

      test('deleteBar throws exception if bar was not deleted', () async {
        when(() => barDao.remove(barFromDB)).thenAnswer((_) async => 0);

        expect(() async => await build().deleteBar(barFromDB), throwsException);
      });

      test('resetBars', () async {
        when(() => barDao.getAll()).thenAnswer((_) async => [barFromDB, barFromDB]);
        when(() => barDao.remove(barFromDB)).thenAnswer((_) async => 1);
        when(() => barDao.addAll(getDefaultBars())).thenAnswer((_) async => [1, 2]);

        expect(await build().resetBars(), [barFromDB, barFromDB]);

        verify(() => barDao.remove(barFromDB)).called(2);
        verify(() => barDao.addAll(getDefaultBars())).called(1);
      });
    });
  });
}
