part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
}

class LanguageInitialize extends LanguageEvent {
  const LanguageInitialize();

  @override
  List<Object> get props => [];
}

class LanguageLoad extends LanguageEvent {
  const LanguageLoad({
    required this.locale,
  });

  final Locale locale;

  @override
  List<Object> get props => [
    locale,
  ];
}