import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'I10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Label for today's Hijri date
  ///
  /// In en, this message translates to:
  /// **'Today\'s date'**
  String get today_hijri;

  /// Search placeholder text
  ///
  /// In en, this message translates to:
  /// **'What do you want to hear?'**
  String get what_do_you_want_hear;

  /// No description provided for @shortcuts.
  ///
  /// In en, this message translates to:
  /// **'Shortcuts'**
  String get shortcuts;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @play_pause.
  ///
  /// In en, this message translates to:
  /// **'Play/Pause'**
  String get play_pause;

  /// No description provided for @mute_unmute.
  ///
  /// In en, this message translates to:
  /// **'Mute/Unmute'**
  String get mute_unmute;

  /// No description provided for @play_next.
  ///
  /// In en, this message translates to:
  /// **'Play Next'**
  String get play_next;

  /// No description provided for @play_previous.
  ///
  /// In en, this message translates to:
  /// **'Play Previous'**
  String get play_previous;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @check_update.
  ///
  /// In en, this message translates to:
  /// **'Check Update'**
  String get check_update;

  /// No description provided for @fullscreen.
  ///
  /// In en, this message translates to:
  /// **'Fullscreen'**
  String get fullscreen;

  /// No description provided for @exit_fullscreen.
  ///
  /// In en, this message translates to:
  /// **'Exit Fullscreen'**
  String get exit_fullscreen;

  /// No description provided for @licenses.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// No description provided for @about_mostaqem.
  ///
  /// In en, this message translates to:
  /// **'About Mostaqem'**
  String get about_mostaqem;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @update_available.
  ///
  /// In en, this message translates to:
  /// **'Update Available?'**
  String get update_available;

  /// No description provided for @yes_update_available.
  ///
  /// In en, this message translates to:
  /// **'Yes, there is an update'**
  String get yes_update_available;

  /// No description provided for @no_update_available.
  ///
  /// In en, this message translates to:
  /// **'No update available'**
  String get no_update_available;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @copy_version.
  ///
  /// In en, this message translates to:
  /// **'Copy Version'**
  String get copy_version;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @downloads.
  ///
  /// In en, this message translates to:
  /// **'Downloads'**
  String get downloads;

  /// No description provided for @broadcasts.
  ///
  /// In en, this message translates to:
  /// **'Broadcasts'**
  String get broadcasts;

  /// No description provided for @occasions.
  ///
  /// In en, this message translates to:
  /// **'Occasions'**
  String get occasions;

  /// No description provided for @save_image.
  ///
  /// In en, this message translates to:
  /// **'Save Image'**
  String get save_image;

  /// No description provided for @choose_image.
  ///
  /// In en, this message translates to:
  /// **'Choose Image'**
  String get choose_image;

  /// No description provided for @no_image_selected.
  ///
  /// In en, this message translates to:
  /// **'No image selected'**
  String get no_image_selected;

  /// No description provided for @image_saved_successfully.
  ///
  /// In en, this message translates to:
  /// **'Image saved successfully'**
  String get image_saved_successfully;

  /// No description provided for @demo.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get demo;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @temp_files.
  ///
  /// In en, this message translates to:
  /// **'Temporary Files'**
  String get temp_files;

  /// No description provided for @delete_files_successfully.
  ///
  /// In en, this message translates to:
  /// **'Files deleted successfully'**
  String get delete_files_successfully;

  /// No description provided for @delete_files.
  ///
  /// In en, this message translates to:
  /// **'Delete Files'**
  String get delete_files;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @change_color.
  ///
  /// In en, this message translates to:
  /// **'Change Color'**
  String get change_color;

  /// No description provided for @choose_color.
  ///
  /// In en, this message translates to:
  /// **'Choose Color'**
  String get choose_color;

  /// No description provided for @change_appearance.
  ///
  /// In en, this message translates to:
  /// **'Change Appearance'**
  String get change_appearance;

  /// No description provided for @reset_color.
  ///
  /// In en, this message translates to:
  /// **'Reset Color'**
  String get reset_color;

  /// No description provided for @change_to_waves.
  ///
  /// In en, this message translates to:
  /// **'Change Shape to Waves'**
  String get change_to_waves;

  /// No description provided for @select_verse_to_share.
  ///
  /// In en, this message translates to:
  /// **'Select verse to share'**
  String get select_verse_to_share;

  /// No description provided for @share_verse.
  ///
  /// In en, this message translates to:
  /// **'Share Verse'**
  String get share_verse;

  /// No description provided for @next_to_play.
  ///
  /// In en, this message translates to:
  /// **'Next to Play'**
  String get next_to_play;

  /// No description provided for @change_location.
  ///
  /// In en, this message translates to:
  /// **'Change Location'**
  String get change_location;

  /// No description provided for @remove_surah_from_queue.
  ///
  /// In en, this message translates to:
  /// **'Remove Surah from Playlist'**
  String get remove_surah_from_queue;

  /// No description provided for @no_special_day_today.
  ///
  /// In en, this message translates to:
  /// **'No special day today'**
  String get no_special_day_today;

  /// No description provided for @hajj_hadith.
  ///
  /// In en, this message translates to:
  /// **'The Prophet said about the virtue of the first ten days of Dhul-Hijjah: (There are no days in which righteous deeds are more beloved to Allah than these ten days. They said: O Messenger of Allah, not even jihad in the way of Allah? He said: Not even jihad in the way of Allah, except a man who goes out with himself and his wealth and returns with nothing from that), narrated by al-Tirmidhi, and its origin is in al-Bukhari.'**
  String get hajj_hadith;

  /// No description provided for @labbayk_allahumma_labbayk.
  ///
  /// In en, this message translates to:
  /// **'Labbayk Allahumma Labbayk'**
  String get labbayk_allahumma_labbayk;

  /// No description provided for @we_recommend_some_surahs.
  ///
  /// In en, this message translates to:
  /// **'We recommend some surahs:'**
  String get we_recommend_some_surahs;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @read_surah.
  ///
  /// In en, this message translates to:
  /// **'Read Surah'**
  String get read_surah;

  /// No description provided for @ramadan.
  ///
  /// In en, this message translates to:
  /// **'Ramadan'**
  String get ramadan;

  /// No description provided for @eid_al_fitr.
  ///
  /// In en, this message translates to:
  /// **'Eid al-Fitr'**
  String get eid_al_fitr;

  /// No description provided for @eid_al_adha.
  ///
  /// In en, this message translates to:
  /// **'Eid al-Adha'**
  String get eid_al_adha;

  /// No description provided for @ashura.
  ///
  /// In en, this message translates to:
  /// **'Ashura'**
  String get ashura;

  /// No description provided for @arafah.
  ///
  /// In en, this message translates to:
  /// **'Day of Arafah'**
  String get arafah;

  /// No description provided for @first_10_days_zul_hijjah.
  ///
  /// In en, this message translates to:
  /// **'First 10 days of Dhul-Hijjah'**
  String get first_10_days_zul_hijjah;

  /// No description provided for @sacred_months.
  ///
  /// In en, this message translates to:
  /// **'Sacred Months'**
  String get sacred_months;

  /// No description provided for @fifteenth_shaaban.
  ///
  /// In en, this message translates to:
  /// **'15th of Sha\'ban'**
  String get fifteenth_shaaban;

  /// No description provided for @islamic_new_year.
  ///
  /// In en, this message translates to:
  /// **'Islamic New Year'**
  String get islamic_new_year;

  /// No description provided for @playlist.
  ///
  /// In en, this message translates to:
  /// **'Playlist'**
  String get playlist;

  /// No description provided for @recitations.
  ///
  /// In en, this message translates to:
  /// **'Recitations'**
  String get recitations;

  /// No description provided for @shuffle.
  ///
  /// In en, this message translates to:
  /// **'Shuffle'**
  String get shuffle;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @repeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeat;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @change_image.
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get change_image;

  /// No description provided for @play_next_item.
  ///
  /// In en, this message translates to:
  /// **'Play Next'**
  String get play_next_item;

  /// No description provided for @add_to_playlist.
  ///
  /// In en, this message translates to:
  /// **'Add to Playlist'**
  String get add_to_playlist;

  /// No description provided for @download_surah.
  ///
  /// In en, this message translates to:
  /// **'Download Surah'**
  String get download_surah;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @lyrics.
  ///
  /// In en, this message translates to:
  /// **'Lyrics'**
  String get lyrics;

  /// No description provided for @sorry_no_lyrics.
  ///
  /// In en, this message translates to:
  /// **'Sorry, no lyrics available, we will add them over time'**
  String get sorry_no_lyrics;

  /// No description provided for @offline_playback.
  ///
  /// In en, this message translates to:
  /// **'Offline Playback'**
  String get offline_playback;

  /// No description provided for @minimize_screen.
  ///
  /// In en, this message translates to:
  /// **'Minimize Screen'**
  String get minimize_screen;

  /// No description provided for @maximize_screen.
  ///
  /// In en, this message translates to:
  /// **'Maximize Screen'**
  String get maximize_screen;

  /// No description provided for @search_reciter.
  ///
  /// In en, this message translates to:
  /// **'Search for reciter...'**
  String get search_reciter;

  /// No description provided for @default_reciter.
  ///
  /// In en, this message translates to:
  /// **'Default Reciter'**
  String get default_reciter;

  /// No description provided for @choose_reciter.
  ///
  /// In en, this message translates to:
  /// **'Choose Reciter'**
  String get choose_reciter;

  /// No description provided for @sorry_no_internet.
  ///
  /// In en, this message translates to:
  /// **'Sorry, no internet connection'**
  String get sorry_no_internet;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get something_went_wrong;

  /// No description provided for @choose_download_location.
  ///
  /// In en, this message translates to:
  /// **'Choose Quran download location'**
  String get choose_download_location;

  /// No description provided for @choose_location.
  ///
  /// In en, this message translates to:
  /// **'Choose Location'**
  String get choose_location;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @add_next.
  ///
  /// In en, this message translates to:
  /// **'Add Next'**
  String get add_next;

  /// No description provided for @add_to_queue.
  ///
  /// In en, this message translates to:
  /// **'Add to Queue'**
  String get add_to_queue;

  /// No description provided for @play_surah.
  ///
  /// In en, this message translates to:
  /// **'Play Surah'**
  String get play_surah;

  /// No description provided for @remove_from_queue.
  ///
  /// In en, this message translates to:
  /// **'Remove from Queue'**
  String get remove_from_queue;

  /// No description provided for @move_item.
  ///
  /// In en, this message translates to:
  /// **'Move Item'**
  String get move_item;

  /// No description provided for @play_item.
  ///
  /// In en, this message translates to:
  /// **'Play Item'**
  String get play_item;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
