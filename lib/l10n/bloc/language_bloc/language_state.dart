part of 'language_bloc.dart';

class LanguageState extends Equatable {
  const LanguageState({
    this.locale = const Locale('en'),
  });

  final Locale locale;

  @override
  List<Object?> get props => [
    locale,
  ];
}