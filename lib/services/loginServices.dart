import 'package:busTransport/uitls/metaData.dart';
import 'package:dio/dio.dart';

class LoginServices {
  final String url = apiUrl;
  Dio dio = new Dio();

  Future<dynamic> login(
    String email,
    String pass,
  ) async {
    return await dio.get("$url/login?email=$email&pass=$pass").then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }
}
