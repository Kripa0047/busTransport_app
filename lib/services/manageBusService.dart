import 'package:busTransport/uitls/metaData.dart';
import 'package:dio/dio.dart';

class ManageBusServices {
  final String url = apiUrl;
  Dio dio = new Dio();

  Future<dynamic> getBuses(
    String token,
  ) async {
    return await dio.get("$url/bus?token=$token").then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }

  Future<dynamic> addBus(String token, String busNo, String description) async {
    return await dio
        .get(
            "$url/bus/add-new?busNo=$busNo&description=$description&token=$token")
        .then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }

  Future<dynamic> deleteBus(String token, String id) async {
    return await dio
        .get("$url/bus/delete?id=$id&token=$token")
        .then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }
}
