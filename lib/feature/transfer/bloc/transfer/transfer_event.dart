part of 'transfer_bloc.dart';

sealed class TransferEvent extends Equatable {
  const TransferEvent();
}

class TransferInitialize extends TransferEvent {
  const TransferInitialize();

  @override
  List<Object?> get props => [];
}

