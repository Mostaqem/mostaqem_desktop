import 'package:mostaqem/src/core/dio/dio_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'crash_report.g.dart';

@riverpod
Future<void> crashReport(Ref ref) async {
  final data = {'user_id': 'BLANK'}; //TODO
  await ref.watch(dioHelperProvider).postHTTP('/bug-report', data, null);
}
