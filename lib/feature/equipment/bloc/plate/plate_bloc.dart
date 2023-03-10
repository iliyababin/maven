
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../dao/plate_dao.dart';
import '../../model/plate.dart';

part 'plate_event.dart';
part 'plate_state.dart';

class PlateBloc extends Bloc<PlateEvent, PlateState> {
  PlateBloc({
    required this.plateDao,
  }) : super(const PlateState()) {
    plateDao.getPlatesAsStream().listen((event) => add(PlateStreamUpdatePlates(plates: event)));

    on<PlateStreamUpdatePlates>(_plateStreamUpdatePlates);

    on<PlateInitialize>(_plateInitialize);
    on<PlateAddEmpty>(_plateAddEmpty);
    on<PlateUpdate>(_plateUpdate);
    on<PlateDelete>(_plateDelete);
  }

  final PlateDao plateDao;

  Future<void> _plateStreamUpdatePlates(PlateStreamUpdatePlates event, emit) async {
    emit(state.copyWith(plates: () => event.plates));
  }

  Future<void> _plateInitialize(PlateInitialize event, emit) async {
    emit(state.copyWith(status: () => PlateStatus.loaded));
  }

  Future<void> _plateAddEmpty(PlateAddEmpty event, emit) async {
    await plateDao.addPlate(const Plate(
      amount: 0,
      color: Colors.pink,
      height: 1,
      isCustomized: false,
      weight: 0,
    ));
  }

  Future<void> _plateUpdate(PlateUpdate event, emit) async {
    await plateDao.updatePlate(event.plate);
  }

  Future<void> _plateDelete(PlateDelete event, emit) async {
    await plateDao.deletePlates(event.plates);
    emit(state.copyWith(status: () => PlateStatus.delete));
  }
}
