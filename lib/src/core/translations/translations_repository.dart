import 'package:flutter/material.dart';
import 'package:mostaqem/src/core/translations/languages.dart';
import 'package:mostaqem/src/shared/I10n/app_localizations.dart';
import 'package:mostaqem/src/shared/cache/cache_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'translations_repository.g.dart';

class I18nRepository {
  static List<Locale> supportedLocales = Language.values.toLocales();
}

@riverpod
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
    final defaultLang = Language.arabic.code;
    final code = CacheHelper.getString('lang') ?? defaultLang;
    return Locale(code);
  }

  void setLocale(Locale locale) {
    state = locale;
    CacheHelper.setString('lang', locale.languageCode);
  }
}

extension Locales on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}
