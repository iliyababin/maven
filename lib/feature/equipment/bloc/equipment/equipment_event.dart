part of 'equipment_bloc.dart';

abstract class EquipmentEvent extends Equatable {
  const EquipmentEvent();

  @override
  List<Object?> get props => [];
}

class EquipmentInitialize extends EquipmentEvent {}

class PlateAddEmpty extends EquipmentEvent {}

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

class PlateReset extends EquipmentEvent {}

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

class BarReset extends EquipmentEvent {}

class BarAddEmpty extends EquipmentEvent {}

class BarStreamUpdateBars extends EquipmentEvent {
  const BarStreamUpdateBars({
    required this.bars,
  });

  final List<Bar> bars;

  @override
  List<Object?> get props => [bars];
}

