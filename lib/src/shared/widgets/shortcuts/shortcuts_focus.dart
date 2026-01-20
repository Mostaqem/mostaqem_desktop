import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final focusManagerProvider = Provider((ref) => FocusManager());

final textFieldFocusProvider = StateProvider.autoDispose<FocusNode?>(
  (ref) => FocusNode(),
);

final shortcutsEnabledProvider = StateProvider<bool>((ref) => true);
