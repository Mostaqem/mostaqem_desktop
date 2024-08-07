import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:mostaqem/src/core/logger/logger_provider.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

final dioHelperProvider = Provider((ref) => DioHelper());

class DioHelper {
  static final String url = Env.apiURL;
  static final talker = LoggerRepository().talker;
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.addAll([
        InterceptorsWrapper(onRequest: (options, handler) {
          return handler.next(options);
        }, onError: (e, handler) async {
          return handler.next(e);
        }),
        TalkerDioLogger(
            talker: talker, 
            settings:
                const TalkerDioLoggerSettings(printResponseMessage: false))
      ]);
  }

  Future<Response?> getHTTP(String url, {Options? options}) async {
    try {
      Response response = await baseAPI.get(url, options: options);
      return response;
    } on DioException catch (e) {
      log("[Get Request Error]", error: e);
      log("[Get Request Error Data]| ${e.response!.data}");
    }
    return null;
  }

  Future<Response?> postHTTP(String url, dynamic data) async {
    try {
      Response response = await baseAPI.post(url, data: data);
      return response;
    } on DioException catch (e) {
      log("PostError", error: e);
    }
    return null;
  }
}
