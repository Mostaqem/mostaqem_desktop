import 'package:flutter_discord_rpc/flutter_discord_rpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discord_provider.g.dart';

class DiscordRepository {
  final _largeImage = 'discord_im';
  final _instance = FlutterDiscordRPC.instance;

  static Future<void> initializeDiscord() async {
    await FlutterDiscordRPC.initialize(Constants.discordAPPID);
  }

  Future<void> updateDiscordPresence({
    required String surahName,
    required String reciter,
    required String url,
  }) async {
    await _instance.connect();

    await _instance.setActivity(
      activity: RPCActivity(
        activityType: ActivityType.listening,
        assets: RPCAssets(largeImage: _largeImage),
        state: reciter,
        details: surahName,
        buttons: [RPCButton(label: 'Listen', url: url)],
      ),
    );
  }

  Future<void> clearDiscordPresence() async {
    final isconnected = _instance.isConnected;
    if (!isconnected) {
      await _instance.connect();
    }
    if (isconnected) {
      await _instance.clearActivity();
    }
  }
}

@riverpod
Future<void> updateRPCDiscord(
  Ref ref, {
  required String surahName,
  required String reciter,
  required String url,
}) async {
  final discord = DiscordRepository();
  return discord.updateDiscordPresence(
    surahName: surahName,
    reciter: reciter,
    url: url,
  );
}

@riverpod
Future<void> clearRPCDiscord(Ref ref) async {
  final discord = DiscordRepository();
  return discord.clearDiscordPresence();
}
