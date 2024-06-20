import 'package:discord_rpc/discord_rpc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'discord_provider.g.dart';

class DiscordRepository {
  DiscordRPC rpc = DiscordRPC(
    applicationId: '1251240254250156195',
  );
  String largeImage = "large";
  String smallImage = "small_image";

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
void updateRPCDiscord(UpdateRPCDiscordRef ref,
    {required String surahName}) {
  final discord = DiscordRepository();
  return discord.updateDiscordPresence(
    surahName: surahName,
  );
}
