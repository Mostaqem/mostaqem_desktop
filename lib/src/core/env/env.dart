import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'PROD_BASE_API', obfuscate: true)
  static final String prodBaseAPI = _Env.prodBaseAPI;
  @EnviedField(varName: 'DEV_BASE_API')
  static const String devBaseAPI = _Env.devBaseAPI;
  @EnviedField(varName: 'MSTORE')
  static const bool mStore = _Env.mStore;
}
