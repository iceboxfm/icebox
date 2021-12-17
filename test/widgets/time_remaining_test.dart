import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:icebox/widgets/time_remaining.dart';

void main() {
  Widget _timeRemainingWidget(final Duration duration) {
    return MaterialApp(
      home: Scaffold(
        body: TimeRemaining(duration),
      ),
    );
  }

  testWidgets(
    'More than 3 months remaining - green',
    (WidgetTester tester) async {
      await tester.pumpWidget(_timeRemainingWidget(const Duration(days: 95)));

      final chipTextFinder = find.text('3 m');

      // verify the text
      expect(chipTextFinder, findsOneWidget);

      // verify text color
      expect(chipTextFinder, IsTextWithColor(Colors.white));

      // verify the background color
      expect(find.byType(Chip), IsChipWithBackgroundColor(Colors.green));
    },
  );

  testWidgets(
    'Less than 2 month remaining - yellow',
    (WidgetTester tester) async {
      await tester.pumpWidget(_timeRemainingWidget(const Duration(days: 50)));

      final chipTextFinder = find.text('2 m');

      // verify the text
      expect(chipTextFinder, findsOneWidget);

      // verify text color
      expect(chipTextFinder, IsTextWithColor(Colors.black));

      // verify the background color
      expect(find.byType(Chip), IsChipWithBackgroundColor(Colors.amber));
    },
  );

  testWidgets(
    'Less than 1 month remaining - red',
    (WidgetTester tester) async {
      await tester.pumpWidget(_timeRemainingWidget(const Duration(days: 25)));

      final chipTextFinder = find.text('25 d');

      // verify the text
      expect(chipTextFinder, findsOneWidget);

      // verify text color
      expect(chipTextFinder, IsTextWithColor(Colors.white));

      // verify the background color
      expect(find.byType(Chip), IsChipWithBackgroundColor(Colors.red));
    },
  );

  testWidgets(
    'Expired - red with icon',
    (WidgetTester tester) async {
      await tester.pumpWidget(_timeRemainingWidget(const Duration(days: 0)));

      final iconFinder = find.byIcon(Icons.error);

      // verify the icon
      expect(iconFinder, findsOneWidget);

      final textFinder = find.byType(Text);
      expect(textFinder, findsNothing);
    },
  );
}

class IsTextWithColor extends CustomMatcher {
  IsTextWithColor(colorValue)
      : super(
          'Text widget with color of',
          'color',
          colorValue,
        );

  @override
  Object featureValueOf(dynamic actual) {
    if (actual is Finder) {
      return _extractColor(actual.evaluate().first.widget as Text);
    } else {
      return _extractColor(actual as Text);
    }
  }

  Color _extractColor(final Text text) {
    return text.style!.color!;
  }
}

class IsChipWithBackgroundColor extends CustomMatcher {
  IsChipWithBackgroundColor(colorValue)
      : super(
          'Chip widget with background color of',
          'backgroundColor',
          colorValue,
        );

  @override
  Object featureValueOf(dynamic actual) {
    if (actual is Finder) {
      return _extractColor(actual.evaluate().first.widget as Chip);
    } else {
      return _extractColor(actual as Chip);
    }
  }

  Color _extractColor(final Chip chip) {
    return chip.backgroundColor!;
  }
}
