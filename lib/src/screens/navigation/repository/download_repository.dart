import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/download_manager.dart';
import 'package:mostaqem/src/screens/navigation/widgets/providers/playing_provider.dart';
import 'package:mostaqem/src/screens/settings/providers/download_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'download_repository.g.dart';

final cancelTokenProvider = StateProvider.autoDispose<CancelToken>(
  (ref) => CancelToken(),
);

enum DownloadState { pending, downloading, finished, cancelled }

class DownloadProgress {
  DownloadProgress({
    required this.count,
    required this.total,
    this.downloadState = DownloadState.pending,
  });
  final int count;
  final int total;
  DownloadState downloadState;

  DownloadProgress copyWith({
    int? count,
    int? total,
    DownloadState? downloadState,
  }) => DownloadProgress(
    count: count ?? this.count,
    total: total ?? this.total,
    downloadState: downloadState ?? this.downloadState,
  );
}

@riverpod
class DownloadAudio extends _$DownloadAudio {
  @override
  DownloadProgress? build() {
    return null;
  }

  Future<void> downloadSurah({required int surahID}) async {
    final downloadPath = ref.watch(downloadDestinationProvider).requireValue;
    final recitationID = ref.watch(currentRecitationProvider);
    final currentReciter = ref.watch(currentReciterProvider);
    if (recitationID == null || currentReciter == null) {
      return;
    }
    final album = await ref.watch(
      fetchAlbumProvider(
        chapterNumber: surahID,
        recitationID: recitationID,
        reciterID: currentReciter.id,
      ).future,
    );
    final mixIDs = recitationID + surahID;
    final savePath = '$downloadPath/$mixIDs.mp3';
    final cancelToken = ref.watch(cancelTokenProvider);
    state = DownloadProgress(count: 0, total: 0);
    await Dio()
        .download(
          album.url,
          savePath,
          cancelToken: cancelToken,
          onReceiveProgress: (count, total) {
            if (count == total) {
              state = state!.copyWith(
                count: count,
                total: total,
                downloadState: DownloadState.finished,
              );
            }
            if (count < total) {
              state = state!.copyWith(
                count: count,
                total: total,
                downloadState: DownloadState.downloading,
              );
            }
          },
        )
        .whenComplete(() async {
          ref.watch(downloadHeightProvider.notifier).state = 0;
          try {
            await writeMetaData(savePath, album);
            ref.watch(cancelTokenProvider.notifier).state = CancelToken();
          } catch (e) {
            log('[Error Writing metadata]', error: e);
          }
        })
        .catchError((e) {
          log('[Error Downloading]', error: e);
          state = state!.copyWith(downloadState: DownloadState.cancelled);
          cancelToken.cancel();
        });
    state = null;
  }

  Future<void> download() async {
    final album = ref.watch(currentAlbumProvider);
    if (album == null) {
      return;
    }
    final downloadPath = ref.watch(downloadDestinationProvider).requireValue;
    final surahID = ref.watch(currentSurahProvider)?.id ?? 0;
    final mixIDs = album.recitationID + surahID;
    final savePath = '$downloadPath/$mixIDs.mp3';
    final cancelToken = ref.watch(cancelTokenProvider);
    state = DownloadProgress(count: 0, total: 0);
    await Dio()
        .download(
          album.url,
          savePath,
          cancelToken: cancelToken,
          onReceiveProgress: (count, total) {
            if (count == total) {
              state = state!.copyWith(
                count: count,
                total: total,
                downloadState: DownloadState.finished,
              );
            }
            if (count < total) {
              state = state!.copyWith(
                count: count,
                total: total,
                downloadState: DownloadState.downloading,
              );
            }
          },
        )
        .whenComplete(() async {
          ref.watch(downloadHeightProvider.notifier).state = 0;
          try {
            await writeMetaData(savePath, album);
          } catch (e) {
            log('[Error Writing metadata]', error: e);
          }
        });
    state = null;
  }

  Future<void> writeMetaData(String filePath, Album album) async {
    await MetadataGod.writeMetadata(
      file: filePath,
      metadata: Metadata(
        genre: 'Quran',
        discNumber: album.surah.id,
        title: album.surah.arabicName,
        artist: album.reciter.arabicName,
      ),
    );
  }
}
