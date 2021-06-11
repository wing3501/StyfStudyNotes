import 'package:dio/dio.dart';

import 'config.dart';

class HttpRequest {
  static final BaseOptions baseOptions = BaseOptions(
      baseUrl: HttpConfig.baseURL, connectTimeout: HttpConfig.timeout);
  static final Dio dio = Dio(baseOptions);
  static Future<T> request<T>(String url,
      {String method = "get",
      Map<String, dynamic> params,
      Interceptor inter}) async {
    final options = Options(method: method);

    Interceptor dInter = InterceptorsWrapper(onRequest: (options, handler) {
      print("请求拦截");
      handler.next(options);
    }, onResponse: (response, handler) {
      // print("响应拦截");
      handler.next(response);
    }, onError: (error, handler) {
      // print("错误拦截");
      handler.next(error);
    });
    List<Interceptor> inters = [dInter];
    if (inter != null) {
      inters.add(inter);
    }
    dio.interceptors.addAll(inters);

    try {
      Response response =
          await dio.request(url, queryParameters: params, options: options);
      return response.data;
    } on DioError catch (e) {
      return Future.error(e);
    }
  }
}
