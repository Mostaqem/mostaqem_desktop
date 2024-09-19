// ignore_for_file: inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:mostaqem/src/core/logger/logger_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_helper.g.dart';

@Riverpod(keepAlive: true)
DioHelper dioHelper(DioHelperRef ref) => DioHelper();

class DioHelper {
  static final String url = Env.apiURL;
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
  );
  CancelToken? _cancelToken;

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
      ]);
  }

  Future<Response<dynamic>> getHTTP(
    String url, {
    Options? options,
  }) async {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel('Request cancelled: New chapter selected');
    }
    _cancelToken = CancelToken();

    try {
      final response =
          await baseAPI.get(url, options: options, cancelToken: _cancelToken);

      return response;
    } on DioException catch (e, _) {
      if (CancelToken.isCancel(e)) {
        print('Request cancelled: $e');
      } else {
        throw Exception('Failed to load MP3: $e');
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> postHTTP(
    String url,
    dynamic data,
  ) async {
    if (_cancelToken != null && !_cancelToken!.isCancelled) {
      _cancelToken!.cancel('Request cancelled: New chapter selected');
    }
    _cancelToken = CancelToken();
    try {
      final response =
          await baseAPI.post(url, data: data, cancelToken: _cancelToken);
      return response;
    } on DioException catch (e, _) {
      if (CancelToken.isCancel(e)) {
        print('Request cancelled: $e');
      } else {
        throw Exception('Failed to load MP3: $e');
      }
      rethrow;
    }
  }
}
