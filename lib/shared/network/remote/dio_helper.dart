import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
        BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        // baseUrl: 'https://newsapi.org/',news app
        receiveDataWhenStatusError: true,
        ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic> ?query,
    var lang = 'en',
    dynamic token,
  }) async {

    dio?.options.headers= {
      'lang': lang,
      'Content-Type':'application/json',
      'Authorization': token,
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    var lang = 'en',
    var token,
  }) async {
    dio?.options.headers= {
      'Content-Type':'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio!.post(url, queryParameters: query, data: data);
  }
}
