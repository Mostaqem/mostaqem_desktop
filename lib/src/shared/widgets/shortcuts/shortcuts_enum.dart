import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ShortcutsEnum {
  help(name: 'مساعدة', key: LogicalKeyboardKey.f1, hidden: true),
  playPause(
    name: 'تشغيل/ايقاف',
    key: LogicalKeyboardKey.space,
  ),
  mute(name: 'صامت/تشغيل', key: LogicalKeyboardKey.keyM),
  playNext(name: 'تشغيل التالي', key: LogicalKeyboardKey.arrowLeft),
  playPrevious(name: 'تشغيل القبل', key: LogicalKeyboardKey.arrowRight),
  repeat(name: 'إعادة', key: LogicalKeyboardKey.keyR),

  settings(name: 'الأعدادات', key: LogicalKeyboardKey.keyP),

  checkUpdate(
    name: 'تحديث',
    key: LogicalKeyboardKey.keyU,
    control: true,
  ),

  enterFullscreen(name: 'الشاشة الكبيرة', key: LogicalKeyboardKey.keyF),
  exitFullscreen(name: 'قفل الشاشة الكبيرة', key: LogicalKeyboardKey.escape),

  quit(name: 'إغلاق مستقيم', key: LogicalKeyboardKey.keyQ, control: true);

  const ShortcutsEnum({
    required this.name,
    required this.key,
    this.control = false,
    this.hidden = false,
  });
  final String name;
  final LogicalKeyboardKey key;
  final bool control;
  final bool hidden;

  void executeCallback(VoidCallback callback) {
    callback();
  }

  ShortcutActivator get activator => SingleActivator(key, control: control);
}
