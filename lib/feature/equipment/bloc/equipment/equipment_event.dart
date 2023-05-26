part of 'equipment_bloc.dart';

abstract class EquipmentEvent extends Equatable {
  const EquipmentEvent();

}

class EquipmentInitialize extends EquipmentEvent {
  const EquipmentInitialize();

  @override
  List<Object?> get props => [];
}

class PlateAddEmpty extends EquipmentEvent {
  const PlateAddEmpty();

  @override
  List<Object?> get props => [];
}

class PlateUpdate extends EquipmentEvent {
  const PlateUpdate({
    required this.plate,
  });

  final Plate plate;

  @override
  List<Object?> get props => [plate];
}

class PlateDelete extends EquipmentEvent {
  const PlateDelete(this.plates);

  final List<Plate> plates;

  @override
  List<Object?> get props => [plates];
}

class PlateReset extends EquipmentEvent {
  const PlateReset();

  @override
  List<Object?> get props => [];
}

class PlateStreamUpdatePlates extends EquipmentEvent {
  const PlateStreamUpdatePlates({
    required this.plates,
  });

  final List<Plate> plates;

  @override
  List<Object?> get props => [plates];
}

class BarDelete extends EquipmentEvent {
  const BarDelete(this.bar);

  final List<Bar> bar;

  @override
  List<Object?> get props => [bar];
}

class BarUpdate extends EquipmentEvent {
  const BarUpdate({
    required this.bar,
  });

  final Bar bar;

  @override
  List<Object?> get props => [bar];
}

class BarReset extends EquipmentEvent {
  const BarReset();

  @override
  List<Object?> get props => [];
}

class BarAddEmpty extends EquipmentEvent {
  const BarAddEmpty();

  @override
  List<Object?> get props => [];
}

class BarStreamUpdateBars extends EquipmentEvent {
  const BarStreamUpdateBars({
    required this.bars,
  });

  final List<Bar> bars;

  @override
  List<Object?> get props => [bars];
}

