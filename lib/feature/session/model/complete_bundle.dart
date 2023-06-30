
import 'package:equatable/equatable.dart';

import '../../../database/database.dart';
import '../session.dart';


class SessionBundle extends Equatable {
  const SessionBundle({
    required this.session,
    required this.sessionExerciseBundles,
    required this.volume,
  });

  final Session session;
  final List<SessionExerciseBundle> sessionExerciseBundles;
  final double volume;

  @override
  List<Object?> get props => [
    session,
    sessionExerciseBundles,
    volume,
  ];
}