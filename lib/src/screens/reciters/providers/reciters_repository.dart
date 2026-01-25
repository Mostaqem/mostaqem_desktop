// ignore_for_file: avoid_dynamic_calls,
// ignore_for_file: inference_failure_on_untyped_parameter,
// ignore_for_file: use_setters_to_change_properties

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/dio/apis.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/reciters/providers/default_reciter.dart';
import 'package:mostaqem/src/screens/settings/appearance/providers/apperance_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reciters_repository.g.dart';

abstract class RecitersRepository {
  Future<List<Reciter>> fetchReciters({required int page});

  Future<Reciter> fetchReciter({required int id});

  Future<List<Reciter>> searchReciter({required String query});
}

class RecitersImpl implements RecitersRepository {
  RecitersImpl(this.ref);
  final Ref ref;

  @override
  Future<Reciter> fetchReciter({required int id}) async {
    final request = await ref
        .watch(dioHelperProvider)
        .getHTTP('/reciters?reciter=$id', baseAPI: APIs.mp3QuranAPI);
    final reciters = request.data['reciters'] as List;
    return Reciter.fromJson(reciters.first as Map<String, Object?>);
  }

  @override
  Future<List<Reciter>> fetchReciters({required int page}) async {
    final request = await ref
        .watch(dioHelperProvider)
        .getHTTP('/reciters', baseAPI: APIs.mp3QuranAPI);
    return request.data['reciters']
        .map<Reciter>((e) => Reciter.fromJson(e as Map<String, Object?>))
        .toList();
  }

  @override
  Future<List<Reciter>> searchReciter({String? query}) async {
    if (query == null || query.isEmpty) return [];
    final reciters = await fetchReciters(page: 1);
    final lowerQuery = query.toLowerCase();
    return reciters
        .where((reciter) => reciter.name.toLowerCase().contains(lowerQuery))
        .toList();
  }
}

final reciterRepositoryProvider = Provider<RecitersImpl>(RecitersImpl.new);

@Riverpod(keepAlive: true)
Future<Reciter> fetchReciter(Ref ref, {required int id}) {
  return ref.watch(reciterRepositoryProvider).fetchReciter(id: id);
}

@Riverpod(keepAlive: true)
Future<List<Reciter>> fetchReciters(Ref ref, {required int page}) {
  return ref.watch(reciterRepositoryProvider).fetchReciters(page: page);
}

@Riverpod(keepAlive: true)
Future<List<Reciter>> searchReciter(Ref ref, {String? query}) {
  return ref.watch(reciterRepositoryProvider).searchReciter(query: query);
}

/// A [UserReciter] class to manage the state of the currently selected reciter.
/// Example:
/// ```dart
/// final reciter = ref.watch(userReciterProvider);
/// ```
///
/// To change the reciter:
/// ```dart
/// ref.read(userReciterProvider.notifier).setReciter(newReciter);
/// ```
@Riverpod(keepAlive: true)
class UserReciter extends _$UserReciter {
  /// Builds and returns the default [Reciter] by watching the
  /// [defaultReciterProvider].
  ///
  /// This method is automatically called when the provider is first accessed
  /// and anytime its dependencies (e.g., [defaultReciterProvider]) change.
  @override
  Reciter build() {
    return ref.watch(defaultReciterProvider);
  }

  /// Sets the currently selected [Reciter].
  ///
  /// This method allows you to update the reciter state by passing a new
  /// [Reciter] object. The state will then be updated and any listeners
  /// watching this provider will be notified of the change.
  ///
  /// Example usage:
  /// ```dart
  /// ref.read(userReciterProvider.notifier).setReciter(newReciter);
  /// ```
  ///
  /// [reciter] - The new [Reciter] to set as the current one.
  void setReciter(Reciter reciter) {
    state = reciter;
  }
}
