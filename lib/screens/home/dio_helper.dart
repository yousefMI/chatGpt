import 'package:dio/dio.dart';

class DioHelper{
  static Dio? dio;
  static initDio(){
    dio =Dio(
      BaseOptions(baseUrl:"https://api.openai.com/v1/chat/",
        followRedirects: false,
        validateStatus: (status) => status!<500,
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 2),
      )
    );
  }
  static Future<Response> postData({required String url,required Map<String,dynamic>data}){
   dio!.options.headers={
     "Authorization": "Bearer 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",
     "Content-Type": "application/json"
   };
    return dio!.post(url,data:data );
  }
}