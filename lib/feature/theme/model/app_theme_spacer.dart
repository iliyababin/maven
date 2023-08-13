class AppThemeSpacer {
  const AppThemeSpacer({
    required this.large,
    required this.medium,
    required this.small,
  });

  final double large;
  final double medium;
  final double small;

  Map<String, double> get spacings => {
        'large': large,
      };
}
