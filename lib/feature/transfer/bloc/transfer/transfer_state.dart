part of 'transfer_bloc.dart';

enum TransferStatus {
  loading,
  loaded,
  error,
}

extension TransferStatusX on TransferStatus {
  bool get isLoading => this == TransferStatus.loading;
  bool get isLoaded => this == TransferStatus.loaded;
  bool get isError => this == TransferStatus.error;
}

class TransferState extends Equatable {
  const TransferState({
    this.status = TransferStatus.loading,
    this.imports = const [],
    this.exports = const [],
  });

  final TransferStatus status;
  final List<Import> imports;
  final List<Export> exports;

  TransferState copyWith({
    TransferStatus? status,
    List<Import>? imports,
    List<Export>? exports,
  }) {
    return TransferState(
      status: status ?? this.status,
      imports: imports ?? this.imports,
      exports: exports ?? this.exports,
    );
  }

  @override
  List<Object?> get props => [
    status,
    imports,
    exports,
  ];
}
