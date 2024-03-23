import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../routine/routine.dart';
import '../../../session/session.dart';
import '../../transfer.dart';

part 'transfer_event.dart';
part 'transfer_state.dart';

class TransferBloc extends Bloc<TransferEvent, TransferState> {
  TransferBloc({
    required this.transferService,
    required this.routineService,
  }) : super(const TransferState()) {
    on<TransferInitialize>(_initialize);
    on<TransferImport>(_import);
  }

  final TransferService transferService;
  final RoutineService routineService;

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

    List<Session> sessions = transferService.parse(event.data, event.source);
    Import import = await transferService.addImport(event.source);

    routineService.addSessions(sessions, import.id!);

    emit(state.copyWith(
      status: TransferStatus.loaded,
      imports: [import, ...state.imports]
    ));
  }
}
