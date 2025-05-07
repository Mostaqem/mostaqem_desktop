// ignore_for_file: inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/dio/apis.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_helper.g.dart';

@Riverpod(keepAlive: true)
DioHelper dioHelper(Ref ref) => DioHelper();

bool isProduction = const bool.fromEnvironment('dart.vm.product');

class DioHelper {
  final dio = Dio();

  Future<Response<dynamic>> getHTTP(
    String url, {
    Options? options,
    String? baseAPI,
  }) async {
    final uri = baseAPI ?? APIs.baseAPIURL;
    final path = '$uri$url';

    final response = await dio.get(path, options: options);
    return response;
  }

  Future<Response<dynamic>> postHTTP(
    String url,
    dynamic data,
    String? baseAPI,
  ) async {
    final uri = baseAPI ?? APIs.baseAPIURL;
    final path = '$uri$url';
    final response = await dio.post(path, data: data);
    return response;
  }
}
