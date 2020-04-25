import '../utils/request.dart';
import 'package:dio/dio.dart';

Future<Response> getHomeData(data) async{
  try {
    Dio dio = Request().getDio();
    Response response = await dio.post('wxmini/homePageContent', queryParameters: data);
    return response;
  } catch (e) {
    print(e);
    return e;
  }
} 