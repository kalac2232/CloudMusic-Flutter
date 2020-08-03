import 'dart:math';

import 'package:cloudmusic/commen/constant/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class HttpRequest {
  static Dio dio;

  BaseOptions baseOptions;

  HttpRequest({this.baseOptions}) {
    //设置基本参数
    if (baseOptions == null) {
      baseOptions = BaseOptions(
          baseUrl: BASE_URL, connectTimeout: 5000, receiveTimeout: 3000 //接受超时
          );
    }

    dio = Dio(baseOptions);
    //配置一个拦截器，这个拦截器 可以在所有的请求发送或失败时统一进行处理
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      print("请求地址:" + options.path);
      return options;
    }, onResponse: (Response response) {
      //print("拿到内容:" + response.toString());
      return response;
    }, onError: (DioError e) {
      print("连接错误:" + e.error.toString());
      return e;
    }));
  }

  Future get({
    @required String path,
    Map<String, dynamic> parameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    return await dio.get(path,
        queryParameters: parameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
  }
}

final HttpRequest httpRequest = HttpRequest();