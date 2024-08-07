import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'download_cache.g.dart';

final downloadDestinationProvider = FutureProvider<String>((ref) async {
  final cache = ref.watch(downloadCacheProvider);

  if (cache != null) {
    return cache;
  }

  final downloadPath = await getDownloadsDirectory();
  return downloadPath!.path;
});

@Riverpod(keepAlive: true)
class DownloadCache extends _$DownloadCache {
  @override
  String? build() {
    final cachedPath = CacheHelper.getString('download');

    if (cachedPath != null) {
      return cachedPath;
    }

    return null;
  }

  Future<void> changePath({required String path}) async {
    state = path;
    await CacheHelper.setString('download', path);
  }
}
