part of 'plate_bloc.dart';

abstract class PlateEvent extends Equatable {
  const PlateEvent();

  @override
  List<Object?> get props => [];
}

class PlateInitialize extends PlateEvent {}

class PlateAddEmpty extends PlateEvent {}

class PlateUpdate extends PlateEvent {
  const PlateUpdate({
    required this.plate,
  });

  final Plate plate;

  @override
  List<Object?> get props => [plate];
}

class PlateDelete extends PlateEvent {
  const PlateDelete(this.plates);

  final List<Plate> plates;

  @override
  List<Object?> get props => [plates];
}

class PlateStreamUpdatePlates extends PlateEvent {
  const PlateStreamUpdatePlates({
    required this.plates,
  });

  final List<Plate> plates;

  @override
  List<Object?> get props => [plates];
}