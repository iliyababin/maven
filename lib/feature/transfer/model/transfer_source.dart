enum TransferSource {
  json,
  strong,
  hevy;

  String get imagePath {
    switch (this) {
      case TransferSource.json:
        return 'assets/images/json.png';
      case TransferSource.strong:
        return 'assets/images/strong.png';
      case TransferSource.hevy:
        return 'assets/images/hevy.png';
    }
  }
}