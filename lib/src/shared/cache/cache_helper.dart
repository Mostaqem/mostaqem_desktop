import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? pref;

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async{
     await pref?.setString(key, value);
  }

  static String? getString(String key) {
    return pref?.getString(key);
  }

  static Future<void> setInt(String key, int value) async {
    await pref?.setInt(key, value);
  }

  static int? getInt(String key) {
    return pref?.getInt(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await pref?.setBool(key, value);
  }

  static bool? getBool(String key) {
    return pref?.getBool(key);
  }

  static Future<void> setList(String key, List<String> value) async {
    await pref?.setStringList(key, value);
  }

  static List<String>? getList(String key) {
    return pref?.getStringList(key);
  }

  static Future<void> remove(key) async {
    await pref?.remove(key);
  }

  static Future<void> clear() async {
    await pref?.clear();
  }
}