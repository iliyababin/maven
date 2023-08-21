import 'package:flutter_test/flutter_test.dart';
import 'package:maven/database/database.dart';

void main() {
  group('tests the streak calculator', () {
    test('no dates', () {
      expect(
        DatabaseService.getWeekStreak(
          [],
        ),
        0,
      );
    });

    test('single current day', () {
      expect(
        DatabaseService.getWeekStreak(
          [
            DateTime.now(),
          ],
        ),
        1,
      );
    });

    test('single date within past week', () {
      expect(
        DatabaseService.getWeekStreak(
          [
            DateTime.now().subtract(const Duration(days: 1)),
          ],
        ),
        1,
      );
    });

    test('single date past the current week', () {
      expect(
        DatabaseService.getWeekStreak(
          [
            DateTime.now().subtract(const Duration(days: 14)),
          ],
        ),
        0,
      );
    });

    test('two date within past week', () {
      expect(
        DatabaseService.getWeekStreak(
          [
            DateTime.now(),
            DateTime.now().subtract(const Duration(days: 2)),
          ],
        ),
        1,
      );
    });

    test('two date within past week and one next', () {
      expect(
        DatabaseService.getWeekStreak(
          [
            DateTime.now().subtract(const Duration(days: 1)),
            DateTime.now().subtract(const Duration(days: 2)),
            DateTime.now().subtract(const Duration(days: 9)),
          ],
        ),
        2,
      );
    });

    test('two date within past week and two on previous', () {
      expect(
        DatabaseService.getWeekStreak(
          [
            DateTime.now().subtract(const Duration(days: 1)),
            DateTime.now().subtract(const Duration(days: 2)),
            DateTime.now().subtract(const Duration(days: 9)),
            DateTime.now().subtract(const Duration(days: 10)),
          ],
        ),
        2,
      );
    });

    test('four dates with gap in front', () {
      expect(
        DatabaseService.getWeekStreak(
          [
            DateTime.now().subtract(const Duration(days: 8)),
            DateTime.now().subtract(const Duration(days: 9)),
            DateTime.now().subtract(const Duration(days: 10)),
            DateTime.now().subtract(const Duration(days: 11)),
          ],
        ),
        0 ,
      );
    });

    test('four dates with gap in between', () {
      expect(
        DatabaseService.getWeekStreak(
          [
            DateTime.now().subtract(const Duration(days: 2)),
            DateTime.now().subtract(const Duration(days: 5)),
            DateTime.now().subtract(const Duration(days: 20)),
            DateTime.now().subtract(const Duration(days: 22)),
          ],
        ),
        1,
      );
    });

  });
}