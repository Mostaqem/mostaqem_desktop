import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../settings/providers/download_cache.dart';
import '../data/album.dart';

part 'download_repository.g.dart';

enum DownloadState { pending, downloading, finished, cancelled }

class DownloadProgress {
  final int count;
  final int total;
  DownloadState downloadState;
  DownloadProgress(
      {required this.count,
      required this.total,
      this.downloadState = DownloadState.pending});

  DownloadProgress copyWith(
          {int? count, int? total, DownloadState? downloadState}) =>
      DownloadProgress(
          count: count ?? this.count,
          total: total ?? this.total,
          downloadState: downloadState ?? this.downloadState);
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
    final savePath = "$downloadPath/$mixID.mp3";
    state = DownloadProgress(
      count: 0,
      total: 0,
    );
    await Dio().download(album.url, savePath,
        onReceiveProgress: (count, total) {
      if (count == total) {
        state = state!.copyWith(
            count: count, total: total, downloadState: DownloadState.finished);
      }
      if (count < total) {
        state = state!.copyWith(
            count: count,
            total: total,
            downloadState: DownloadState.downloading);
      }
    }).whenComplete(() async {
      try {
        final metadata = await MetadataGod.readMetadata(file: savePath);
        if (metadata.title == null) {
          await writeMetaData(savePath, album);
        }
      } catch (e) {
        log("[Error reading metadata]", error: e);
      }
    });
    state = null;
  }

  Future<void> writeMetaData(String filePath, Album album) async {
    await MetadataGod.writeMetadata(
        file: filePath,
        metadata: Metadata(
          title: album.surah.arabicName,
          artist: album.reciter.arabicName,
        ));
  }
}
