import 'package:busTransport/uitls/metaData.dart';
import 'package:dio/dio.dart';

class LocationServices {
  final String url = apiUrl;
  Dio dio = new Dio();

  Future<dynamic> getLocations(
    String token,
  ) async {
    return await dio.get("$url/location?token=$token").then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }

  Future<dynamic> addLocation(String token, String location) async {
    return await dio
        .get("$url/location/add-new?location=$location&token=$token")
        .then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }

  Future<dynamic> deleteLocation(String token, String id) async {
    return await dio
        .get("$url/location/delete?id=$id&token=$token")
        .then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }
}
