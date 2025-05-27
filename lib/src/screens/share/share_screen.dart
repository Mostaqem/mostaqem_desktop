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
    super.key,
    this.verse = 'بسم الله الرحمن الرحيم',
  });
  final String verse;
  final String surahName;

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  File? image;
  bool loading = false;

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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.verse,
                          maxLines: 2,
                          style: GoogleFonts.amiri(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Text(
                        '- ${widget.surahName} - ',
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
                  ElevatedButton.icon(
                    onPressed: image != null
                        ? () async {
                            if (loading) return;

                            final repo = ShareRepository(
                              context: context,
                              verse: widget.verse,
                              surahName: widget.surahName,
                              image: image,
                            );
                            setState(() {
                              loading = true;
                            });

                            await repo.exportImage().whenComplete(() {
                              setState(() {
                                loading = false;
                              });
                            });
                          }
                        : null,

                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      minimumSize: const WidgetStatePropertyAll(Size(50, 60)),
                    ),
                    label: const Text('حفظ الصورة'),
                    icon: loading
                        ? SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Theme.of(
                                context,
                              ).colorScheme.onPrimaryContainer,
                            ),
                          )
                        : const Icon(Icons.check_circle, size: 30),
                  ),
                  ElevatedButton.icon(
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
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('لم يتم اختيار صورة')),
                          );
                        }
                      }
                    },
                    label: const Text('اختر صورة'),
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      minimumSize: const WidgetStatePropertyAll(Size(50, 60)),
                    ),
                    icon: const Icon(Icons.image_rounded, size: 30),
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
