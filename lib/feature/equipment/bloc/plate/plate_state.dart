part of 'plate_bloc.dart';

enum PlateStatus {
  loading,
  loaded,
  delete,
}
class PlateState extends Equatable {
  const PlateState({
    this.status = PlateStatus.loading,
    this.plates = const [],
  });

  final PlateStatus status;
  final List<Plate> plates;

  PlateState copyWith({
    PlateStatus Function()? status,
    List<Plate> Function()? plates,
  }) {
    return PlateState(
      status: status != null ? status() : this.status,
      plates: plates != null ? plates() : this.plates,
    );
  }

  @override
  List<Object?> get props => [
    plates,
    status,
  ];
}