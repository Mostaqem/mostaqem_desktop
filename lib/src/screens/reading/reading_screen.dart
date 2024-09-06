import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/screens/reading/providers/reading_providers.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';

class ReadingScreen extends ConsumerWidget {
  const ReadingScreen({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scripts = ref.watch(fetchUthmaniScriptProvider(surahID: id));
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const WindowButtons(),
            const SizedBox(
              height: 10,
            ),
            const AppBackButton(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: AsyncWidget(
                  value: scripts,
                  data: (data) {
                    return ListView.separated(
                      itemCount: data.length,
                      separatorBuilder: (c, i) => const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 10,
                        ),
                        child: Divider(
                          height: 50,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        return Text(
                          data[index].verse,
                          // textAlign: TextAlign.center,
                          style: GoogleFonts.amiriQuran(
                            fontSize: 25,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
