import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioHelperProvider = Provider((ref) => DioHelper());

class DioHelper {
  static const String url = 'https://api.quran.com/api/v4';
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: const Duration(milliseconds: 30000),
    receiveTimeout: const Duration(milliseconds: 30000),
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static final dio = createDio();

  Future<Response?> getHTTP(String url) async {
    try {
      Response response = await dio.get(url);
      return response;
    } on DioException catch (e) {
      log("getError", error: e);
    }
    return null;
  }

  Future<Response?> postHTTP(String url, dynamic data) async {
    try {
      Response response = await dio.post(url, data: data);
      return response;
    } on DioException catch (e) {
      log("PostError", error: e);
    }
    return null;
  }
}
