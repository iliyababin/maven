import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../transfer.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  final TransferService transferService;

  TransferBloc({
    required this.transferService,
  }) : super(const TransferState()) {
    on<TransferInitialize>(_initialize);
    on<TransferImport>(_import);
  }

  Future<void> _initialize(TransferInitialize event, Emitter<TransferState> emit) async {
    emit(state.copyWith(
      status: TransferStatus.loaded,
      imports: await transferService.getImports(),
      exports: await transferService.getExports(),
    ));
  }

  Future<void> _import(TransferImport event, Emitter<TransferState> emit) async {
    emit(state.copyWith(
      status: TransferStatus.loading,
    ));

    // await transferService.import(event.import);

    emit(state.copyWith(
      status: TransferStatus.loaded,
      imports: await transferService.getImports(),
      exports: await transferService.getExports(),
    ));
  }
}
