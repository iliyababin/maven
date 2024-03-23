part of 'transfer_bloc.dart';

sealed class TransferEvent extends Equatable {
  const TransferEvent();
}

class TransferInitialize extends TransferEvent {
  const TransferInitialize();

  @override
  List<Object?> get props => [];
}

class TransferImport extends TransferEvent {
  final TransferSource source;
  final String data;

  const TransferImport({
    required this.source,
    required this.data,
  });

  @override
  List<Object?> get props => [
        source,
        data,
      ];
}
