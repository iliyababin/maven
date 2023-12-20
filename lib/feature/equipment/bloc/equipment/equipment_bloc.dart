import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../database/database.dart';
import '../../equipment.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  EquipmentBloc({
    required this.equipmentService,
  }) : super(const EquipmentState()) {
    on<EquipmentInitialize>(_initialize);
    on<PlateAdd>(_plateAdd);
    on<PlateUpdate>(_plateUpdate);
    on<PlateDelete>(_plateDelete);
    on<PlateReset>(_plateReset);
    on<BarAdd>(_barAdd);
    on<BarUpdate>(_barUpdate);
    on<BarDelete>(_barDelete);
    on<BarReset>(_barReset);
  }

  final EquipmentService equipmentService;

  Future<void> _initialize(EquipmentInitialize event, emit) async {
    emit(state.copyWith(
      status: EquipmentStatus.loaded,
      bars: await equipmentService.getAllBars(),
      plates: await equipmentService.getAllPlates(),
    ));
  }

  Future<void> _plateAdd(PlateAdd event, emit) async {
    emit(state.copyWith(
      status: EquipmentStatus.loading,
    ));

    Plate plate = await equipmentService.addPlate(event.plate);

    emit(state.copyWith(
      status: EquipmentStatus.loaded,
      plates: [...state.plates, plate],
    ));
  }

  Future<void> _plateUpdate(PlateUpdate event, emit) async {
    emit(state.copyWith(
      status: EquipmentStatus.loading,
    ));

    Plate plate = await equipmentService.updatePlate(event.plate);

    emit(state.copyWith(
      status: EquipmentStatus.loaded,
      plates: [
        for (Plate p in state.plates)
          if (p.id == plate.id) plate else p
      ],
    ));
  }

  Future<void> _plateDelete(PlateDelete event, emit) async {
    emit(state.copyWith(
      status: EquipmentStatus.loading,
    ));

    await equipmentService.deletePlate(event.plate);

    emit(state.copyWith(
      status: EquipmentStatus.loaded,
      plates: [
        for (Plate p in state.plates)
          if (p.id != event.plate.id) p
      ],
    ));
  }

  Future<void> _plateReset(PlateReset event, emit) async {
    emit(state.copyWith(
      status: EquipmentStatus.loading,
    ));

    List<Plate> plates = await equipmentService.resetPlates();

    emit(state.copyWith(
      status: EquipmentStatus.loaded,
      plates: plates,
    ));
  }

  Future<void> _barAdd(BarAdd event, emit) async {
    emit(state.copyWith(
      status: EquipmentStatus.loading,
    ));

    Bar bar = await equipmentService.addBar(event.bar);

    emit(state.copyWith(
      status: EquipmentStatus.loaded,
      bars: [
        ...state.bars,
        bar,
      ],
    ));
  }

  Future<void> _barUpdate(BarUpdate event, emit) async {
    emit(state.copyWith(
      status: EquipmentStatus.loading,
    ));

    Bar bar = await equipmentService.updateBar(event.bar);

    emit(state.copyWith(
      status: EquipmentStatus.loaded,
      bars: [
        for (Bar b in state.bars)
          if (b.id == bar.id) bar else b
      ],
    ));
  }

  Future<void> _barDelete(BarDelete event, emit) async {
    emit(state.copyWith(
      status: EquipmentStatus.loading,
    ));

    await equipmentService.deleteBar(event.bar);

    emit(state.copyWith(
      status: EquipmentStatus.loaded,
      bars: [
        for (Bar b in state.bars)
          if (b.id != event.bar.id) b
      ],
    ));
  }

  Future<void> _barReset(BarReset event, emit) async {
    emit(state.copyWith(
      status: EquipmentStatus.loading,
    ));

    List<Bar> bars = await equipmentService.resetBars();

    emit(state.copyWith(
      status: EquipmentStatus.loaded,
      bars: bars,
    ));
  }
}
