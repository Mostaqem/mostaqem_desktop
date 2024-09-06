// ignore_for_file: inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:mostaqem/src/core/logger/logger_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

part 'dio_helper.g.dart';

@Riverpod(keepAlive: true)
DioHelper dioHelper(DioHelperRef ref) => DioHelper();

class DioHelper {
  static final String url = Env.apiURL;
  static final talker = LoggerRepository().talker;
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  static Dio addInterceptors(Dio dio) {
    return dio
      ..interceptors.addAll([
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.next(options);
          },
          onError: (e, handler) async {
            return handler.next(e);
          },
        ),
        TalkerDioLogger(
          talker: talker,
          settings: const TalkerDioLoggerSettings(
            printResponseData: false,
          ),
        ),
      ]);
  }

  Future<Response<dynamic>> getHTTP(
    String url, {
    Options? options,
  }) async {
    final response = await baseAPI.get(url, options: options);
    return response;
  }

  Future<Response<dynamic>> postHTTP(
    String url,
    dynamic data,
  ) async {
    final response = await baseAPI.post(url, data: data);
    return response;
  }
}
