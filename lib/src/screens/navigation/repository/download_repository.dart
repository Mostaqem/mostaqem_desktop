import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:mostaqem/src/screens/navigation/data/album.dart';
import 'package:mostaqem/src/screens/navigation/widgets/player/download_manager.dart';
import 'package:mostaqem/src/screens/settings/providers/download_cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'download_repository.g.dart';

final cancelTokenProvider =
    StateProvider.autoDispose<CancelToken>((ref) => CancelToken());

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
  }) =>
      DownloadProgress(
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

  Future<void> download({required Album album}) async {
    final downloadPath = ref.watch(downloadDestinationProvider).requireValue;
    final mixID = album.surah.id + album.reciter.id;
    final savePath = '$downloadPath/$mixID.mp3';
    final cancelToken = ref.watch(cancelTokenProvider);
    state = DownloadProgress(
      count: 0,
      total: 0,
    );
    await Dio().download(
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
    ).whenComplete(() async {
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
        title: album.surah.arabicName,
        artist: album.reciter.arabicName,
      ),
    );
  }
}
