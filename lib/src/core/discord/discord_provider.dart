import 'package:flutter_discord_rpc/flutter_discord_rpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discord_provider.g.dart';

class DiscordImp {
  String largeImage = 'discord_im';

  Future<void> updateDiscordPresence({
    required String surahName,
    required int position,
    required int duration,
    required String reciter,
  }) async {
    final isconnected = FlutterDiscordRPC.instance.isConnected;

    await FlutterDiscordRPC.instance.connect(autoRetry: true);
    if (isconnected) {
      await FlutterDiscordRPC.instance.setActivity(
        activity: RPCActivity(
          activityType: ActivityType.listening,
          state: reciter,
          details: surahName,
          assets: RPCAssets(largeImage: largeImage),
          timestamps: RPCTimestamps(start: position, end: duration),
        ),
      );
    } else {
      await FlutterDiscordRPC.instance.reconnect();
      try {
        await FlutterDiscordRPC.instance.setActivity(
          activity: RPCActivity(
            activityType: ActivityType.listening,
            state: reciter,
            details: surahName,
            assets: RPCAssets(largeImage: largeImage),
            timestamps: RPCTimestamps(start: position, end: duration),
          ),
        );
      } catch (e) {}
    }
  }
}

@riverpod
Future<void> updateRPCDiscord(
  Ref ref, {
  required String surahName,
  required int position,
  required int duration,
  required String reciter,
}) async {
  final discord = DiscordImp();
  return discord.updateDiscordPresence(
    surahName: surahName,
    position: position,
    duration: duration,
    reciter: reciter,
  );
}
