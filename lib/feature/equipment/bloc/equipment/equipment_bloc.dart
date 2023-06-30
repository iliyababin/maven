
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../database/database.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  EquipmentBloc({
    required this.plateDao,
    required this.barDao,
  }) : super(const EquipmentState()) {
    plateDao.getPlatesAsStream().listen((event) => add(PlateStreamUpdatePlates(plates: event)));
    barDao.getBarsAsStream().listen((event) => add(BarStreamUpdateBars(bars: event)));

    on<PlateStreamUpdatePlates>(_plateStreamUpdatePlates);

    on<EquipmentInitialize>(_equipmentInitialize);

    on<PlateAddEmpty>(_plateAddEmpty);
    on<PlateUpdate>(_plateUpdate);
    on<PlateDelete>(_plateDelete);
    on<PlateReset>(_plateReset);

    on<BarAddEmpty>(_barAddEmpty);
    on<BarUpdate>(_barUpdate);
    on<BarDelete>(_barDelete);
    on<BarReset>(_barReset);
    on<BarStreamUpdateBars>(_barStreamUpdateBars);
  }

  final PlateDao plateDao;
  final BarDao barDao;

  Future<void> _plateStreamUpdatePlates(PlateStreamUpdatePlates event, emit) async {
    emit(state.copyWith(plates: () => event.plates));
  }

  Future<void> _barStreamUpdateBars(BarStreamUpdateBars event, emit) async {
    emit(state.copyWith(bars: () => event.bars));
  }

  Future<void> _equipmentInitialize(EquipmentInitialize event, emit) async {
    emit(state.copyWith(status: () => EquipmentStatus.loaded));
  }

  Future<void> _plateAddEmpty(PlateAddEmpty event, emit) async {
    await plateDao.addPlate(const Plate(
      amount: 0,
      color: Colors.pink,
      height: 1,
      weight: 0,
    ));
  }

  Future<void> _plateUpdate(PlateUpdate event, emit) async {
    await plateDao.updatePlate(event.plate);
  }

  Future<void> _plateDelete(PlateDelete event, emit) async {
    await plateDao.deletePlates(event.plates);
    emit(state.copyWith(status: () => EquipmentStatus.delete));
  }

  Future<void> _plateReset(PlateReset event, emit) async {
    await plateDao.deleteAllPlates();
    await plateDao.addPlates(getDefaultPlates());
  }

  Future<void> _barAddEmpty(BarAddEmpty event, emit) async {
    await barDao.addBar(const Bar(
      name: 'Untitled',
      weight: 0,
    ));
  }

  Future<void> _barUpdate(BarUpdate event, emit) async {
    await barDao.updateBar(event.bar);
  }

  Future<void> _barDelete(BarDelete event, emit) async {
    await barDao.deleteBars(event.bar);
    emit(state.copyWith(status: () => EquipmentStatus.delete));
  }

  Future<void> _barReset(BarReset event, emit) async {
    await barDao.deleteAllBars();
    await barDao.addBars(getDefaultBars());
  }
}
