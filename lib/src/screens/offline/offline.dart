// ignore_for_file: invalid_use_of_protected_member,
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mostaqem/src/screens/navigation/repository/player_repository.dart';
import 'package:mostaqem/src/screens/offline/repository/offline_repository.dart';
import 'package:mostaqem/src/shared/widgets/async_widget.dart';
import 'package:mostaqem/src/shared/widgets/tooltip_icon.dart';
import 'package:vector_graphics/vector_graphics_compat.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: Consumer(
            builder: (context, ref, child) {
              final localAudio = ref.watch(getLocalAudioProvider);

              return AsyncWidget(
                value: localAudio,
                error: (e, s) {
                  if (e is PathNotFoundException) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 16,
                        children: [
                          const Text(
                            'Download folder may be deleted or moved somewhere, You can change it in settings',
                          ),
                          ElevatedButton(
                            onPressed: () => context.push('/settings'),
                            child: const Text('Settings'),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: Text('Error'));
                },
                data: (data) {
                  if (data.isEmpty) {
                    return Center(
                      child: VectorGraphic(
                        loader: const AssetBytesLoader(
                          'assets/img/svg/empty_box.svg',
                        ),
                        width: 220,
                        colorFilter: ColorFilter.mode(
                          const Color.fromARGB(
                            255,
                            202,
                            197,
                            197,
                          ).withValues(alpha: 0.5),
                          BlendMode.modulate,
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    itemCount: data.length,
                    separatorBuilder: (context, _) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(data[index].surah.arabicName),
                        subtitle: Text(data[index].reciter.arabicName),
                        onTap: () {
                          ref
                              .read(playerNotifierProvider.notifier)
                              .localPlay(
                                album: data[index].copyWith(isLocal: true),
                              );
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ToolTipIconButton(
                              message: 'اقرأ السورة',
                              onPressed: () {
                                context.pushNamed(
                                  'Reading',
                                  extra: data[index].surah,
                                );
                              },
                              icon: const VectorGraphic(
                                loader: AssetBytesLoader(
                                  'assets/img/svg/read.svg',
                                ),
                                width: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
