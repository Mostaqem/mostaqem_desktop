import 'dart:io';

import 'package:flutter_discord_rpc/flutter_discord_rpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discord_provider.g.dart';

class DiscordImp {
  String largeImage = 'large';
  String smallImage = 'small_image';

  void updateDiscordPresence({
    required String surahName,
    required int position,
    required int duration,
    required String reciter,
  }) {
    if (!Platform.isMacOS) {
      final isconnected = FlutterDiscordRPC.instance.isConnected;

      if (isconnected) {
        FlutterDiscordRPC.instance.setActivity(
          activity: RPCActivity(
            activityType: ActivityType.listening,
            state: surahName,
            details: reciter,
            timestamps: RPCTimestamps(
              start: position,
              end: duration,
            ),
            assets: RPCAssets(
              largeImage: largeImage,
              smallText: smallImage,
            ),
          ),
        );
      } else {
        FlutterDiscordRPC.instance.connect();
        FlutterDiscordRPC.instance.setActivity(
          activity: RPCActivity(
            activityType: ActivityType.listening,
            state: surahName,
            details: reciter,
            timestamps: RPCTimestamps(
              start: position,
              end: duration,
            ),
            assets: RPCAssets(
              largeImage: largeImage,
              smallText: smallImage,
            ),
          ),
        );
      }
    }
  }
}

@riverpod
void updateRPCDiscord(
  Ref ref, {
  required String surahName,
  required int position,
  required int duration,
  required String reciter,
}) {
  final discord = DiscordImp();
  return discord.updateDiscordPresence(
    surahName: surahName,
    position: position,
    duration: duration,
    reciter: reciter,
  );
}
