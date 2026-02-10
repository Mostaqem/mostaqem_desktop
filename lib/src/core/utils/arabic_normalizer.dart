String normalizeArabic(String text) {
  return text
      .replaceAll(RegExp('[أإآا]'), 'ا')
      .replaceAll('ة', 'ه')
      .replaceAll(RegExp('[\u064B-\u065F]'), '');
}
