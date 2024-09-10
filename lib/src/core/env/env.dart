import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'APIURL', obfuscate: true)
  static final String apiURL = _Env.apiURL;
  @EnviedField(varName: 'MSTORE')
  static const bool mStore = _Env.mStore;
}
