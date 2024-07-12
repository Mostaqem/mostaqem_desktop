import 'package:discord_rpc/discord_rpc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discord_provider.g.dart';

abstract class DiscordRepository {
  void updateDiscordPresence({
    required String surahName,
    required int position,
    required int duration,
    required String reciter,
  });
}

class DiscordImp implements DiscordRepository {
  DiscordRPC rpc = DiscordRPC(
    applicationId: '1251240254250156195',
  );
  String largeImage = "large";
  String smallImage = "small_image";

  @override
  void updateDiscordPresence({
    required String surahName,
    required int position,
    required int duration,
    required String reciter,
  }) {
    rpc.start(autoRegister: true);
    rpc.updatePresence(
      DiscordPresence(
        
        state: surahName,
        startTimeStamp: position,
        endTimeStamp: duration,
        details: reciter,
        largeImageKey: largeImage,
        smallImageKey: smallImage,
      ),
    );
  }
}

@riverpod
void updateRPCDiscord(
  UpdateRPCDiscordRef ref, {
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
      reciter: reciter);
}
