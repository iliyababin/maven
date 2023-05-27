class PaddingOptions {
  const PaddingOptions({
    required this.page,
  });

  final double page;

  Map<String, double> get paddings => {
    'page': page,
  };
}
