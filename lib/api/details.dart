import '../utils/request.dart';
import 'package:dio/dio.dart';

Future<Response> getGoodDetailsById(data) async{
  try {
    Dio dio = Request().getDio();
    Response response = await dio.post('wxmini/getGoodDetailById', queryParameters: data);
    return response;
  } catch (e) {
    print(e);
    return e;
  }
}
