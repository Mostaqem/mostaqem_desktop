import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';
import 'package:path_provider/path_provider.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key, this.verse = 'بسم الله الرحمن الرحيم'});
  final String verse;

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final _previewKey = GlobalKey();
  File image = File('');

  Future<void> saveFullResolutionNetworkImageWithText() async {
    try {
      final bytes = await image.readAsBytes();

      // 2. Decode the image
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      final originalImage = frame.image;

      // 3. Create a picture recorder
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(
        recorder,
        Rect.fromPoints(
          Offset.zero,
          Offset(
            originalImage.width.toDouble(),
            originalImage.height.toDouble(),
          ),
        ),
      )..drawImage(originalImage, Offset.zero, Paint());

      // 5. Draw the text
      final versePainter = TextPainter(
        maxLines: 1,
        textAlign: TextAlign.center,

        text: TextSpan(
          text: widget.verse,
          style: GoogleFonts.amiri(
            color: Colors.white,
            fontSize: _calculateFontSize(originalImage),
          ),
        ),
        textDirection: TextDirection.rtl,
      )..layout(
        maxWidth: originalImage.width.toDouble(), // Constrain to image width
      );
      final offset = Offset(
        (originalImage.width - versePainter.width) / 2, // Horizontal center
        (originalImage.height - versePainter.height) / 2, // Vertical center
      );
      versePainter.paint(canvas, offset);

      final logoPainter = TextPainter(
        text: TextSpan(
          text: 'مستقيم',

          style: GoogleFonts.kufam(
            color: Colors.white,
            fontSize: _calculateFontSize(originalImage) / 2,
          ),
        ),
        textDirection: TextDirection.rtl, 
      )..layout(maxWidth: originalImage.width.toDouble());

      // Calculate center-bottom position
      final logoOffset = Offset(
        (originalImage.width - logoPainter.width) / 2, // Horizontal center
        originalImage.height - logoPainter.height - 20, // 20 pixels from bottom
      );

      logoPainter.paint(canvas, logoOffset);
      // 6. Convert to image
      final picture = recorder.endRecording();
      final compositeImage = await picture.toImage(
        originalImage.width,
        originalImage.height,
      );

      // 7. Convert to byte data
      final byteData = await compositeImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final pngBytes = byteData!.buffer.asUint8List();

      // 8. Save to file
      final directory = await getApplicationDocumentsDirectory();
      final path =
          '${directory.path}/mostaqem_${DateTime.now().millisecondsSinceEpoch}.png';
      await File(path).writeAsBytes(pngBytes);

      print('Image saved to: $path');
    } catch (e) {
      print('Error saving image: $e');
      throw Exception('Failed to save image: $e');
    }
  }

  double _calculateFontSize(ui.Image image) {
    final height = image.height.toDouble();
    return height * 0.05;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 100),
              Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 5,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(image.path),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.verse,
                    style: GoogleFonts.amiri(color: Colors.white, fontSize: 26),
                  ),
                ],
              ),

              ElevatedButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );

                  if (result != null) {
                    final file = File(result.files.single.path!);
                    setState(() {
                      image = file;
                    });
                  } else {
                    // User canceled the picker
                  }
                },
                style: const ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    StarBorder(points: 4, pointRounding: 0.65, rotation: 45),
                  ),
                  minimumSize: WidgetStatePropertyAll(Size(150, 150)),
                ),
                child: const Icon(Icons.image_rounded, size: 25),
              ),
            ],
          ),

          Container(
            height: 100,
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                const WindowButtons(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ToolTipIconButton(
                      message: 'حفظ الصورة',
                      onPressed: saveFullResolutionNetworkImageWithText,
                      icon: const Icon(Icons.save_alt_outlined),
                    ),
                    const Text(
                      'تجريبي',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: AppBackButton(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
