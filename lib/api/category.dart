import '../utils/request.dart';
import 'package:dio/dio.dart';

Future<Response> getCategory() async{
  try {
    Dio dio = Request().getDio();
    Response response = await dio.post('wxmini/getCategory');
    return response;
  } catch (e) {
    print(e);
    return e;
  }
}
