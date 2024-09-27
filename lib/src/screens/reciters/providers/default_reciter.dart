import 'dart:convert';

import 'package:mostaqem/src/screens/reciters/data/reciters_data.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'default_reciter.g.dart';

@Riverpod(keepAlive: true)
class DefaultReciter extends _$DefaultReciter {
  @override
  Reciter build() {
    final cachedReciter = CacheHelper.getString('defaultReciter');
    if (cachedReciter == null) {
      return const Reciter(
        id: 1,
        englishName: 'AbdelBaset',
        arabicName: 'عبدالباسط عبدالصمد',
        isDefault: true,
      );
    }
    return Reciter.fromJson(jsonDecode(cachedReciter) as Map<String, dynamic>);
  }

  void setDefault(Reciter reciter) {
    state = reciter;
    CacheHelper.setString(
      'defaultReciter',
      jsonEncode(reciter),
    );
  }
}
