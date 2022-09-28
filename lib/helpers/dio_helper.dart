import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(baseUrl: 'https://student.valuxapps.com/api/'));
  }

  static Future<Response> postData(url, data) async {
    dio!.options.headers = {'lang': 'en'};


    return await dio!.post(url, data: data);
  }

  static Future<Response?> getData({required url, String? alToken}) async {
    dio!.options.headers = {'Authorization': alToken, 'lang': 'en'};

    return await dio?.get(url);
  }
}
