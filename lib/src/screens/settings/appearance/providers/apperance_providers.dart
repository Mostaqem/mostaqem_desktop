import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'apperance_providers.g.dart';

@riverpod
class Apperance extends _$Apperance {
  @override
  Color build() {
    return Theme; //TODO
  }
}
