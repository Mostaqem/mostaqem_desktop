import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef _GetMetadataDart = Metadata Function(Pointer<Utf8> filename);
typedef _SetMetadataDart =
    int Function(
      Pointer<Utf8> filePath,
      Pointer<Utf8> title,
      Pointer<Utf8> artist,
      Pointer<Utf8> album,
      Pointer<Utf8> genre,
      int year,
      int track,
    );

class _MetadataBindings {
  _MetadataBindings() {
    _lib = DynamicLibrary.open('linux/bin/zaglib.so');

    getMetadata = _lib
        .lookupFunction<Metadata Function(Pointer<Utf8>), _GetMetadataDart>(
          'getMetadata',
        );
    setMetadata = _lib
        .lookupFunction<
          Int32 Function(
            Pointer<Utf8>,
            Pointer<Utf8>,
            Pointer<Utf8>,
            Pointer<Utf8>,
            Pointer<Utf8>,
            Int32,
            Int32,
          ),
          _SetMetadataDart
        >('setMetadata');
  }
  late final DynamicLibrary _lib;

  late final _GetMetadataDart getMetadata;
  late final _SetMetadataDart setMetadata;
}

abstract class MetadataRepository {
  Future<Metadata> getMetadata(String filename);
  Future<int> setMetadata({
    required String filePath,
    required String title,
    required String artist,
    required String album,
    required String genre,
    required int year,
    required int track,
  });
}

/// FFI Implementation
class FfiMetadataRepository implements MetadataRepository {
  final _bindings = _MetadataBindings();

  @override
  Future<Metadata> getMetadata(String filename) async {
    final filenamePtr = filename.toNativeUtf8();
    try {
      final meta = _bindings.getMetadata(filenamePtr);
      return meta;
    } finally {
      calloc.free(filenamePtr);
    }
  }

  @override
  Future<int> setMetadata({
    required String filePath,
    required String title,
    required String artist,
    required String album,
    required String genre,
    required int year,
    required int track,
  }) async {
    final filePathPtr = filePath.toNativeUtf8();
    final titlePtr = title.toNativeUtf8();
    final artistPtr = artist.toNativeUtf8();
    final albumPtr = album.toNativeUtf8();
    final genrePtr = genre.toNativeUtf8();

    try {
      final result = _bindings.setMetadata(
        filePathPtr,
        titlePtr,
        artistPtr,
        albumPtr,
        genrePtr,
        year,
        track,
      );
      return result;
    } finally {
      calloc.free(titlePtr);
    }
  }
}

sealed class Metadata extends Struct {
  external Pointer<Utf8> title;
  external Pointer<Utf8> artist;
  external Pointer<Utf8> album;
  external Pointer<Utf8> genre;
  @Uint32()
  external int year;
  @Uint32()
  external int track;

  String? getTitle() => title == nullptr ? null : title.toDartString();
  String? getArtist() => artist == nullptr ? null : artist.toDartString();
  String? getAlbum() => album == nullptr ? null : album.toDartString();
  String? getGenre() => genre == nullptr ? null : genre.toDartString();
}
