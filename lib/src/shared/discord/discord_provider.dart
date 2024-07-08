import 'package:discord_rpc/discord_rpc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discord_provider.g.dart';

abstract class DiscordRepository {
  void updateDiscordPresence({required String surahName});
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
  }) {
    rpc.start(autoRegister: true);
    rpc.updatePresence(
      DiscordPresence(
        state: surahName,
        details: 'Listening To',
        largeImageKey: largeImage,
        smallImageKey: smallImage,
      ),
    );
  }
}

@Riverpod(keepAlive: true)
void updateRPCDiscord(UpdateRPCDiscordRef ref, {required String surahName}) {
  final discord = DiscordImp();
  return discord.updateDiscordPresence(
    surahName: surahName,
  );
}
