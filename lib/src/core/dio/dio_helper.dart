// ignore_for_file: inference_failure_on_function_invocation

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mostaqem/src/core/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_helper.g.dart';

@Riverpod(keepAlive: true)
DioHelper dioHelper(Ref ref) => DioHelper();

bool isProduction = const bool.fromEnvironment('dart.vm.product');
final baseAPIURL = isProduction ? Constants.prodBaseAPI : Constants.devBaseAPI;

class DioHelper {
  static final String url = baseAPIURL;
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    headers: {'Accept-Language': 'ar'},
  );
  static Dio createDio() {
    return Dio(opts);
  }

  static final dio = createDio();

  Future<Response<dynamic>> getHTTP(String url, {Options? options}) async {
    final response = await dio.get(url, options: options);
    return response;
  }

  Future<Response<dynamic>> postHTTP(String url, dynamic data) async {
    final response = await dio.post(url, data: data);
    return response;
  }
}
