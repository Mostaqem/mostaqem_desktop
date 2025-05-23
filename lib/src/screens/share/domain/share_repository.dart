import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/shared/widgets/snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

class ShareRepository {
  ShareRepository({
    required this.context,
    required this.verse,
    required this.surahName,
    required this.verseNumber,
    this.image,
  });
  final BuildContext context;
  final String verse;
  final String surahName;
  final String verseNumber;
  final File? image;
  ui.PictureRecorder? _recorder;

  Future<void> exportImage() async {
    try {
      final originalImage = await _loadOriginalImage();
      final canvas = _createCanvas(originalImage);

      _drawBaseImage(canvas, originalImage);
      _drawVerseText(canvas, originalImage);
      _drawDetailsText(canvas, originalImage);
      await _drawLogo(canvas, originalImage);

      final pngBytes = await _finalizeImage(originalImage);
      await _saveImage(pngBytes);

      if (context.mounted) {
        appSnackBar(context, message: 'لقد تم حفظ الصورة بنجاح');
      }
    } catch (e) {
      throw Exception('Failed to save image: $e');
    } finally {
      _recorder?.endRecording();
    }
  }

  // Private helper methods
  Future<ui.Image> _loadOriginalImage() async {
    final bytes = await image?.readAsBytes();
    if (bytes == null) throw Exception('No image provided');

    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Canvas _createCanvas(ui.Image originalImage) {
    _recorder = ui.PictureRecorder();
    return Canvas(
      _recorder!,
      Rect.fromPoints(
        Offset.zero,
        Offset(originalImage.width.toDouble(), originalImage.height.toDouble()),
      ),
    );
  }

  void _drawBaseImage(Canvas canvas, ui.Image originalImage) {
    final paint = Paint()
      ..colorFilter = ColorFilter.mode(
        Colors.black.withValues(alpha: 0.3),
        BlendMode.darken,
      );
    canvas.drawImage(originalImage, Offset.zero, paint);
  }

  void _drawVerseText(Canvas canvas, ui.Image originalImage) {
    final versePainter = TextPainter(
      maxLines: 3,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: verse,
        style: GoogleFonts.amiri(
          color: Colors.white,
          fontSize: _calculateFontSize(originalImage),
        ),
      ),
      textDirection: TextDirection.rtl,
    )..layout(maxWidth: originalImage.width.toDouble());

    final offset = Offset(
      (originalImage.width - versePainter.width) / 2,
      (originalImage.height - versePainter.height) / 2,
    );
    versePainter.paint(canvas, offset);
  }

  void _drawDetailsText(Canvas canvas, ui.Image originalImage) {
    final detailsPainter = TextPainter(
      maxLines: 1,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '$surahName : $verseNumber',
        style: GoogleFonts.amiri(
          color: Colors.white,
          fontSize: _calculateFontSize(originalImage) * 0.8,
        ),
      ),
      textDirection: TextDirection.rtl,
    )..layout(maxWidth: originalImage.width.toDouble());

    final spacing = _calculateFontSize(originalImage) * 0.5;
    final detailsOffset = Offset(
      (originalImage.width - detailsPainter.width) / 2,
      ((originalImage.height - detailsPainter.height) / 2) +
          (_calculateFontSize(originalImage) * 2) +
          spacing,
    );
    detailsPainter.paint(canvas, detailsOffset);
  }

  Future<void> _drawLogo(Canvas canvas, ui.Image originalImage) async {
    const paddingFromEdge = 30.0;
    const logoWidth = 80.0;

    final logoImage = await _loadLogoImage();
    final logoHeight = logoWidth * (logoImage.height / logoImage.width);

    final logoPaint = Paint()
      ..filterQuality = FilterQuality.high
      ..colorFilter = const ColorFilter.mode(Colors.white, BlendMode.srcATop);

    final logoOffset = Offset(
      originalImage.width.toDouble() - logoWidth - paddingFromEdge,
      originalImage.height - logoHeight - paddingFromEdge,
    );

    canvas.drawImageRect(
      logoImage,
      Rect.fromLTWH(
        0,
        0,
        logoImage.width.toDouble(),
        logoImage.height.toDouble(),
      ),
      Rect.fromLTWH(logoOffset.dx, logoOffset.dy, logoWidth, logoHeight),
      logoPaint,
    );
  }

  Future<ui.Image> _loadLogoImage() async {
    final byteData = await rootBundle.load('assets/img/logo.png');
    final bytes = byteData.buffer.asUint8List();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<Uint8List> _finalizeImage(ui.Image originalImage) async {
    if (_recorder == null) throw Exception('PictureRecorder not initialized');

    final picture = _recorder!.endRecording();
    final compositeImage = await picture.toImage(
      originalImage.width,
      originalImage.height,
    );
    final byteData = await compositeImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData!.buffer.asUint8List();
  }

  Future<void> _saveImage(Uint8List pngBytes) async {
    final savePath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Image',
      initialDirectory: (await getApplicationDocumentsDirectory()).path,
      fileName: 'mostaqem_${DateTime.now().millisecondsSinceEpoch}.png',
      type: FileType.image,
    );

    if (savePath != null) {
      await File(savePath).writeAsBytes(pngBytes);
    }
  }

  double _calculateFontSize(ui.Image image) {
    return image.width * 0.03; 
  }
}
