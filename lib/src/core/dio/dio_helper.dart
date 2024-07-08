import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioHelperProvider = Provider((ref) => DioHelper());

class DioHelper {
  static const String url = 'https://mostaqem-api.onrender.com/api/v1';
  static BaseOptions opts = BaseOptions(
    baseUrl: url,  
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static final dio = createDio();

  Future<Response?> getHTTP(String url, {Options? options}) async {
    try {
      Response response = await dio.get(url, options: options);
      return response;
    } on DioException catch (e) {
      log("[Get Request Error]", error: e);
      log("[Get Request Error Data]| ${e.response!.data}");
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
