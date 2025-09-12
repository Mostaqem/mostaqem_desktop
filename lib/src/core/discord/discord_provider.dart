import 'package:flutter_discord_rpc/flutter_discord_rpc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discord_provider.g.dart';

class DiscordRepository {
  String largeImage = 'discord_im';

  static Future<void> initializeDiscord() async {
    await FlutterDiscordRPC.initialize(Constants.discordAPPID);
  }

  Future<void> updateDiscordPresence({
    required String surahName,
    required String reciter,
    required String url,
  }) async {
    final isconnected = FlutterDiscordRPC.instance.isConnected;
  }

  Future<void> clearDiscordPresence() async {
    final isconnected = FlutterDiscordRPC.instance.isConnected;
    if (!isconnected) {
      await FlutterDiscordRPC.instance.connect();
    }
    if (isconnected) {
      await FlutterDiscordRPC.instance.clearActivity();
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
