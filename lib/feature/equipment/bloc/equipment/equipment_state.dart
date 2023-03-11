part of 'equipment_bloc.dart';

enum EquipmentStatus {
  loading,
  loaded,
  delete,
}

class EquipmentState extends Equatable {
  const EquipmentState({
    this.status = EquipmentStatus.loading,
    this.plates = const [],
    this.bars = const [],
  });

  final EquipmentStatus status;
  final List<Plate> plates;
  final List<Bar> bars;

  EquipmentState copyWith({
    EquipmentStatus Function()? status,
    List<Plate> Function()? plates,
    List<Bar> Function()? bars,
  }) {
    return EquipmentState(
      status: status != null ? status() : this.status,
      plates: plates != null ? plates() : this.plates,
      bars: bars != null ? bars() : this.bars,
    );
  }

  @override
  List<Object?> get props => [
    plates,
    bars,
    status,
  ];
}