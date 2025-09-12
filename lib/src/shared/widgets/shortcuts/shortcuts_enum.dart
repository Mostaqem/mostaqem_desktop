import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mostaqem/src/core/translations/translations_repository.dart';

enum ShortcutsEnum {
  help(key: LogicalKeyboardKey.f1, hidden: true),
  playPause(key: LogicalKeyboardKey.space),
  mute(key: LogicalKeyboardKey.keyM, control: true),
  playNext(key: LogicalKeyboardKey.arrowLeft),
  playPrevious(key: LogicalKeyboardKey.arrowRight),
  repeat(key: LogicalKeyboardKey.keyR, control: true),
  settings(key: LogicalKeyboardKey.keyP, control: true),
  checkUpdate(key: LogicalKeyboardKey.keyU, control: true),
  enterFullscreen(key: LogicalKeyboardKey.keyF, control: true),
  exitFullscreen(key: LogicalKeyboardKey.escape),
  quit(key: LogicalKeyboardKey.keyQ, control: true);

  const ShortcutsEnum({
    required this.key,
    this.control = false,
    this.hidden = false,
  });
  final LogicalKeyboardKey key;
  final bool control;
  final bool hidden;

  String getName(BuildContext context) {
    switch (this) {
      case ShortcutsEnum.help:
        return context.tr.help;
      case ShortcutsEnum.playPause:
        return context.tr.play_pause;
      case ShortcutsEnum.mute:
        return context.tr.mute_unmute;
      case ShortcutsEnum.playNext:
        return context.tr.play_next;
      case ShortcutsEnum.playPrevious:
        return context.tr.play_previous;
      case ShortcutsEnum.repeat:
        return context.tr.repeat;
      case ShortcutsEnum.settings:
        return context.tr.settings;
      case ShortcutsEnum.checkUpdate:
        return context.tr.check_update;
      case ShortcutsEnum.enterFullscreen:
        return context.tr.fullscreen;
      case ShortcutsEnum.exitFullscreen:
        return context.tr.exit_fullscreen;
      case ShortcutsEnum.quit:
        return context.tr.exit;
    }
  }

  void executeCallback(VoidCallback callback) {
    callback();
  }

  ShortcutActivator get activator => SingleActivator(key, control: control);
}
