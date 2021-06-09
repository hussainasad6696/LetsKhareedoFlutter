import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:letskhareedo/WebServices/apis/app_exception.dart';
import 'package:letskhareedo/constants/constant.dart';

class WebService {
  String contentType = 'Content-Type';
  String dataType = 'application/json; charset=UTF-8';

  Future<dynamic> getJson(String url) async {
    dynamic responseJson;
    try {
      print("$BASE_URL_HTTP$url webService");
      final response = await get(Uri.http(BASE_URL_HTTP, url));
      print("got json $response");
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException(" No Internet connection");
    } catch (e) {
      print("WebService error: $e");
    }
    return responseJson;
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        return FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }

  Future<http.Response> postData(Map data, String path) async {
    return http.post(Uri.http(BASE_URL_HTTP, path),
        headers: <String, String>{contentType: dataType},
        body: jsonEncode(data));
  }
}
