import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:mostaqem/src/screens/home/data/surah.dart';
import 'package:mostaqem/src/screens/home/providers/home_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'special_repository.g.dart';

class SpecialRepository {
  SpecialRepository(this.ref);
  Ref ref;
  bool isRamadan() {
    final today = HijriCalendar.now();
    return today.hMonth == 9;
  }

  bool isEidAlFitr() {
    final today = HijriCalendar.now();
    return today.hMonth == 10 && today.hDay == 1;
  }

  bool isEidAlAdha() {
    final today = HijriCalendar.now();
    return today.hMonth == 12 && today.hDay == 10;
  }

  bool isAshura() {
    final today = HijriCalendar.now();
    return today.hMonth == 1 && today.hDay == 10;
  }

  bool isArafah() {
    final today = HijriCalendar.now();
    return today.hMonth == 12 && today.hDay == 9;
  }

  bool isFirst10DaysOfZulHijjah() {
    final today = HijriCalendar.now();
    return today.hMonth == 12 && today.hDay <= 10;
  }

  bool isHorom() {
    final today = HijriCalendar.now();
    final hMonth = today.hMonth;
    return hMonth >= 11 || hMonth <= 2;
  }

  bool is15thShaaban() {
    final today = HijriCalendar.now();
    return today.hMonth == 8 && today.hDay == 15;
  }

  bool isIslamicNewYear() {
    final today = HijriCalendar.now();
    return today.hMonth == 1 && today.hDay == 1;
  }

  String? todayDayName() {
    if (isRamadan()) return 'رمضان';
    if (isEidAlFitr()) return 'عيد الفطر';
    if (isEidAlAdha()) return 'عيد الأضحى';
    if (isAshura()) return 'عاشوراء';
    if (isArafah()) return 'يوم عرفة';
    if (isFirst10DaysOfZulHijjah()) return 'العشر الأوائل من ذي الحجة';
    if (isHorom()) return 'الأشهر الحرم';
    if (is15thShaaban()) return 'ليلة النصف من شعبان';
    if (isIslamicNewYear()) return 'رأس السنة الهجرية';
    return null;
  }

  bool isTodaySpecial() {
    return todayDayName() != null;
  }

  List<int> getSpecialSurahsIDs() {
    if (isRamadan()) return [2, 97, 108];
    if (isEidAlFitr()) return [1, 108];
    if (isEidAlAdha()) return [2, 22, 37];
    if (isAshura()) return [2, 10];
    if (isArafah()) return [2, 5];
    if (isFirst10DaysOfZulHijjah()) return [2, 22, 37];
    if (isHorom()) return [2, 5];
    if (is15thShaaban()) return [36, 44];
    if (isIslamicNewYear()) return [1, 112];
    return [];
  }

  Future<List<Surah>> getSpecialSurahs() async {
    final surahs = await ref.watch(
      fetchAllChaptersProvider(page: 1, take: 20).future,
    );
    surahs.shuffle();
    return surahs;
  }
}

@riverpod
SpecialRepository specialRepo(Ref ref) => SpecialRepository(ref);

@riverpod
Future<List<Surah>> specialSurahs(Ref ref) async {
  final repository = ref.watch(specialRepoProvider);
  return repository.getSpecialSurahs();
}
