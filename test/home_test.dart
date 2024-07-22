import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/home/home_screen.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/home/widgets/hijri_date_widget.dart';

void main() {
  group("Test Home Screen", () {
    testWidgets('Test Text in Home Screen', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 500));

      await tester.pumpWidget(ProviderScope(overrides: [
        filterSurahByQueryProvider.overrideWith((ref) => [
              const Surah(
                  id: 1,
                  simpleName: "si",
                  arabicName: "arabicName",
                  revelationPlace: "revelationPlace")
            ]),
      ], child: MaterialApp(home: HomeScreen())));

      await tester.pump();

      expect(find.text("تاريخ اليوم"), findsOneWidget);

      expect(find.text("arabicName"), findsNWidgets(1));

      expect(find.byType(HijriDateWidget), findsOneWidget);
    });

    testWidgets('Test Search in Home Screen', (WidgetTester tester) async {
      await tester.binding.setSurfaceSize(const Size(1280, 780));

      await tester.pumpWidget(ProviderScope(overrides: [
        fetchAllChaptersProvider.overrideWith((ref) {
          return [
            const Surah(
                id: 0,
                simpleName: "simpleName",
                arabicName: "arabicName",
                revelationPlace: "revelationPlace")
          ];
        }),
      ], child: MaterialApp(home: HomeScreen())));

      await tester.pump();

      // Find Nothing when search for something not found
      expect(find.text("ماذا تريد ان تسمع؟"), findsOneWidget);

      final searchBar = find.byType(SearchBar);

      await tester.enterText(searchBar, "fff");

      await tester.pumpAndSettle();

      expect(find.text("arabicName"), findsNothing);

      await tester.enterText(searchBar, "arabic");

      await tester.pumpAndSettle();

      expect(find.text("arabicName"), findsOneWidget);

      await tester.enterText(searchBar, "arabicName");

      await tester.pumpAndSettle();

      expect(find.text("arabicName"), findsNWidgets(2));
    });
  });
}
