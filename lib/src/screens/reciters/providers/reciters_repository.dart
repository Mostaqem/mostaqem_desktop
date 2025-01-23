// ignore_for_file: avoid_dynamic_calls,
// ignore_for_file: inference_failure_on_untyped_parameter,
// ignore_for_file: use_setters_to_change_properties

import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/screens/reciters/providers/default_reciter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reciters_repository.g.dart';

abstract class RecitersRepository {
  Future<List<Reciter>> fetchReciters({
    required int page,
  });

  Future<Reciter> fetchReciter({required int id});

  Future<List<Reciter>> searchReciter({required String query});
}

class RecitersImpl implements RecitersRepository {
  RecitersImpl(this.ref);
  final Ref ref;
  @override
  Future<Reciter> fetchReciter({required int id}) async {
    final request = await ref.watch(dioHelperProvider).getHTTP('/reciter/$id');
    return Reciter.fromJson(request.data['data'] as Map<String, dynamic>);
  }

  @override
  Future<List<Reciter>> fetchReciters({
    required int page,
  }) async {
    final url = '/reciter?page=$page&take=20';

    final request = await ref.watch(dioHelperProvider).getHTTP(url);
    return request.data['data']['reciters']
        .map<Reciter>((e) => Reciter.fromJson(e as Map<String, Object?>))
        .toList();
  }

  @override
  Future<List<Reciter>> searchReciter({String? query}) async {
    final url = '/reciter/search?name=$query';

    final request = await ref.watch(dioHelperProvider).getHTTP(url);
    return request.data['data']['reciters']
        .map<Reciter>((e) => Reciter.fromJson(e as Map<String, Object?>))
        .toList();
  }
}

final reciterRepositoryProvider = Provider<RecitersImpl>(RecitersImpl.new);

@riverpod
Future<Reciter> fetchReciter(Ref ref, {required int id}) {
  return ref.watch(reciterRepositoryProvider).fetchReciter(id: id);
}

@riverpod
Future<List<Reciter>> fetchReciters(
  Ref ref, {
  required int page,
}) {
  return ref.watch(reciterRepositoryProvider).fetchReciters(page: page);
}

@riverpod
Future<List<Reciter>> searchReciter(
  Ref ref, {
  String? query,
}) {
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
