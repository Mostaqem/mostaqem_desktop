// smtc_stub.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'smtc_stub.g.dart';

// Stub implementation for platforms other than Windows
class SMTCRepository {
  SMTCRepository(Ref ref);

  void init({
    required String surah,
    required String reciter,
    required String image,
    required int position,
    required int duration,
  }) {
    // Stub implementation: does nothing
  }

  void updateSMTC({
    required String surah,
    required String reciter,
    required String image,
  }) {
    // Stub implementation: does nothing
  }
}

@riverpod
SMTCRepository smtcRepo(SmtcRepoRef ref) {
  return SMTCRepository(ref);
}

@riverpod
void updateSMTC(
  UpdateSMTCRef ref, {
  required String surah,
  required String reciter,
  required String image,
}) {}

@riverpod
void initSMTC(
  InitSMTCRef ref, {
  required String surah,
  required String reciter,
  required String image,
  required int position,
  required int duration,
}) {}
