import 'package:talker_flutter/talker_flutter.dart';

class LoggerRepository {
  final talker = TalkerFlutter.init();

  void warning(String msg) {
    talker.warning(msg);
  }

  void info(String msg) {
    talker.info(msg);
  }

  void debug(String msg) {
    talker.debug(msg);
  }

  void error(Exception e, StackTrace st) {
    talker.handle(e, st);
  }
}

