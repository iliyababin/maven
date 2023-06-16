import '../database.dart';

List<Bar> getDefaultBars() => [
  const Bar(
    id: 1,
    name: 'Olympic',
    weight: 45,
  ),
  const Bar(
    id: 2,
    name: 'EZ Curl',
    weight: 15,
  ),
  const Bar(
    id: 3,
    name: 'Trap Bar',
    weight: 55,
  ),
];