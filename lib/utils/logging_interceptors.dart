import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoggingInterceptors extends InterceptorsWrapper {
  LoggingInterceptors() {
    print("==> LoggingInterceptors initialized <==");
  }

  @override
  Future<FutureOr> onRequest(RequestOptions options) async {
    print(
        "\n==> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")} <==\n");
    if (options.data != null) {
      debugPrint("==> Body: ${options.data} <==\n\n");
    }
    return options;
  }

  @override
  Future<FutureOr> onError(DioError dioError) async {
    print("==> ${dioError.message} "
        "${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')} <==");
    print(
        "${dioError.response != null ? dioError.response.data : 'Unknown Error'}");
    print("==> End error <==");
  }

  @override
  Future<FutureOr> onResponse(Response response) async {
//    print(
//        "==> ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')} <==\n");
//    debugPrint("Response: ${response.data}\n");
  }
}
