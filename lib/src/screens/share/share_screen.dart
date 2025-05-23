import 'dart:io';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mostaqem/src/screens/share/domain/share_repository.dart';
import 'package:mostaqem/src/shared/widgets/back_button.dart';
import 'package:mostaqem/src/shared/widgets/window_buttons.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({
    required this.surahName,
    required this.verseNumber,
    super.key,
    this.verse = 'بسم الله الرحمن الرحيم',
  });
  final String verse;
  final String surahName;
  final String verseNumber;

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  File? image;

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
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),

                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 5,
                          ),
                          image: image != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withValues(alpha: 0.3),
                                    BlendMode.darken,
                                  ),
                                  image: FileImage(image!),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    spacing: 10,
                    children: [
                      Text(
                        widget.verse,
                        style: GoogleFonts.amiri(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        '${widget.surahName} :  ${widget.verseNumber}',
                        style: GoogleFonts.amiri(
                          color: Colors.white,
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Tooltip(
                    message: 'حفظ الصورة',
                    child: FilledButton(
                      onPressed: image != null
                          ? () async {
                              final repo = ShareRepository(
                                context: context,
                                verse: widget.verse,
                                surahName: widget.surahName,
                                verseNumber: widget.verseNumber,
                                image: image,
                              );
                              await repo.exportImage();
                            }
                          : null,
                      style: const ButtonStyle(
                        shape: WidgetStatePropertyAll(
                          StarBorder(points: 3, pointRounding: 0.65),
                        ),
                        minimumSize: WidgetStatePropertyAll(Size(150, 150)),
                      ),
                      child: const Icon(Icons.check_circle, size: 30),
                    ),
                  ),
                  Tooltip(
                    message: 'اختر صورة',
                    child: ElevatedButton(
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
                          StarBorder(pointRounding: 0.8),
                        ),
                        minimumSize: WidgetStatePropertyAll(Size(150, 150)),
                      ),
                      child: const Icon(Icons.image_rounded, size: 30),
                    ),
                  ),
                ],
              ),
            ],
          ),

          Container(
            height: 100,
            color: Theme.of(context).colorScheme.surface,
            child: const Column(
              children: [
                WindowButtons(),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'تجريبي',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: AppBackButton(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
