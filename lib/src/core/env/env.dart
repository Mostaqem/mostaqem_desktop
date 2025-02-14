class Constants {
  static String devBaseAPI = const String.fromEnvironment('DEV_BASE_API');

  static String prodBaseAPI = const String.fromEnvironment('PROD_BASE_API');

  static bool mStore = const bool.fromEnvironment('MSTORE');
  static String discordAPPID = const String.fromEnvironment('DISCORD');
}
