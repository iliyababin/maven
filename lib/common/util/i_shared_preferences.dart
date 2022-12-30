import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class ISharedPrefs extends InheritedWidget {
  const ISharedPrefs({
    super.key,
    required this.streamingSharedPreferences,
    required super.child,
  });

  final StreamingSharedPreferences streamingSharedPreferences;

  static ISharedPrefs? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ISharedPrefs>();
  }

  static ISharedPrefs of(BuildContext context) {
    final ISharedPrefs? result = maybeOf(context);
    return result!;
  }

  @override
  bool updateShouldNotify(ISharedPrefs oldWidget) => streamingSharedPreferences != oldWidget.streamingSharedPreferences;

}