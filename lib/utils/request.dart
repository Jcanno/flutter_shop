import 'package:dio/dio.dart';
import '../config/index.dart';

class Request {

  // static final Request _singleton = Request._internal();
  // static Dio _dio;

  final BaseOptions options = BaseOptions(
      connectTimeout: 15000,
      receiveTimeout: 15000,
      responseType: ResponseType.json,
      contentType: 'x-www-form-urlencoded',
      validateStatus: (status){
        // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
        return true;
      },
      baseUrl: baseUrl,
  );

  getDio() {
    return Dio(options);
  }

  // Request();

  // Request._internal(){
  //   _dio = Dio(options);
  // }

  // factory Request() {
  //   return Dio(options) as Request;
  // }
  
  // Future<Response> request(String method, String url, [
  //   Map<String, dynamic> queryParameters
  // ]) async{
  //   Response res;
  //   print(queryParameters);
  //   // return null;
  //   try{
  //     res = await _dio.request(
  //       url, 
  //       options: Options(method: method), 
  //       queryParameters: queryParameters, 
  //     );
  //     return res;
  //   }catch(e) {
  //     return null;
  //   }
  // }
}