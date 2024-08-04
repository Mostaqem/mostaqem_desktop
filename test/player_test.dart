import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_kit/media_kit.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player_widget.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';

void main() {
  const channel = MethodChannel('com.alexmercerind/media_kit');
  setUp(() {
    handler(MethodCall methodCall) async {
      if (methodCall.method == 'ensureInitialized') {
        return true;
      }
      return null;
    }

    TestWidgetsFlutterBinding.ensureInitialized();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, handler);
    MediaKit.ensureInitialized();
  });
  testWidgets("Test Player Widget", (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 500));

    const surah = Surah(
        id: 0,
        simpleName: "simpleName",
        arabicName: "arabicName",
        revelationPlace: "revelationPlace");

    const reciter = Reciter(
        id: 0, englishName: "reciterName", arabicName: "reciterArabicName");

    await tester.pumpWidget(ProviderScope(overrides: [
      playerSurahProvider.overrideWith(
          (ref) => const Album(surah: surah, reciter: reciter, url: "url")),
    ], child: const MaterialApp(home: PlayerWidget())));

    expect(find.text("arabicName"), findsOneWidget);
  });
}
