class SpaceOptions {
  const SpaceOptions({
    required this.large,
  });

  final double large;

  Map<String, double> get spacings => {
        'large': large,
      };
}
