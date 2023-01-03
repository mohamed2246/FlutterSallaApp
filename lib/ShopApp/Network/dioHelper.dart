import 'package:dio/dio.dart';

class dioHelper {
  static Dio dio = Dio();

  static intia() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? queres,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {'Content-Type' : 'application/json','lang': lang, 'Authorization': token??''  };

    return await dio.get(url, queryParameters: queres??null);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {'Content-Type' : 'application/json','lang': lang, 'Authorization': token??''  };

    return await dio.post(url, data: data);
  }


  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    String lang = "en",
    String? token,
  }) async {
    dio.options.headers = {'Content-Type' : 'application/json','lang': lang, 'Authorization': token??''  };

    return await dio.put(url, data: data);
  }



}
