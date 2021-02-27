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

  Future<dynamic> updateBus(
    String token,
    String id,
    String busNumber,
    String description,
  ) async {
    return await dio
        .get(
            "$url/bus/update?id=$id&busNumber=$busNumber&description=$description&token=$token")
        .then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }

  Future<dynamic> updateDays(
    String token,
    String id,
    List<String> days,
  ) async {
    return await dio
        .post("$url/bus/update/days?id=$id&token=$token", data: days)
        .then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }

  Future<dynamic> updateStops(
    String token,
    String id,
    List<Map<String, String>> stops,
  ) async {
    return await dio
        .post("$url/bus/update/stops?id=$id&token=$token", data: stops)
        .then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }

  Future<dynamic> filterSearch(
    String from,
    String to,
    String day,
  ) async {
    return await dio
        .get("$url/bus/filter?from=$from&to=$to&day=$day")
        .then((response) {
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response;
      }
    });
  }
}
