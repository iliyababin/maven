part of 'equipment_bloc.dart';

enum EquipmentStatus {
  loading,
  loaded,
}

extension EquipmentStatusX on EquipmentStatus {
  bool get isLoading => this == EquipmentStatus.loading;
  bool get isLoaded => this == EquipmentStatus.loaded;
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
    EquipmentStatus? status,
    List<Plate>? plates,
    List<Bar>? bars,
  }) {
    return EquipmentState(
      status: status ?? this.status,
      plates: plates ?? this.plates,
      bars: bars ?? this.bars,
    );
  }

  @override
  List<Object?> get props => [
    plates,
    bars,
    status,
  ];
}