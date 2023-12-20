part of 'equipment_bloc.dart';

abstract class EquipmentEvent extends Equatable {
  const EquipmentEvent();
}

class EquipmentInitialize extends EquipmentEvent {
  const EquipmentInitialize();

  @override
  List<Object?> get props => [];
}

class PlateAdd extends EquipmentEvent {
  const PlateAdd(this.plate);

  final Plate plate;

  @override
  List<Object?> get props => [plate];
}

class PlateUpdate extends EquipmentEvent {
  const PlateUpdate(this.plate);

  final Plate plate;

  @override
  List<Object?> get props => [plate];
}

class PlateDelete extends EquipmentEvent {
  const PlateDelete(this.plate);

  final Plate plate;

  @override
  List<Object?> get props => [plate];
}

class PlateReset extends EquipmentEvent {
  const PlateReset();

  @override
  List<Object?> get props => [];
}

class BarAdd extends EquipmentEvent {
  const BarAdd(this.bar);

  final Bar bar;

  @override
  List<Object?> get props => [bar];
}

class BarDelete extends EquipmentEvent {
  const BarDelete(this.bar);

  final Bar bar;

  @override
  List<Object?> get props => [bar];
}

class BarUpdate extends EquipmentEvent {
  const BarUpdate(this.bar);

  final Bar bar;

  @override
  List<Object?> get props => [bar];
}

class BarReset extends EquipmentEvent {
  const BarReset();

  @override
  List<Object?> get props => [];
}
