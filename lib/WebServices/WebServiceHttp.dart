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
      final response = await get(Uri.http(BASE_URL_HTTP, url));
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

 static getAddressFromLatLng(context, double lat, double lng) async {
   try {
     String _host = 'https://maps.google.com/maps/api/geocode/json';
     var mapApiKey = "AIzaSyDQVnUnkicHLoptzvwPc1L5h8NWgBtK60c";
     final url = '$_host?key=$mapApiKey&language=en&latlng=$lat,$lng';
     if (lat != null && lng != null) {
       var response = await get(Uri.parse(url));
       if (response.statusCode == 200) {
         Map data = jsonDecode(response.body);
         String _formattedAddress = data["results"][0]["formatted_address"];
         print("response ==== $_formattedAddress");
         return _formattedAddress;
       } else return null;
     } else return null;
   } catch (e) {
     print("$e ---------------------------------------");
   }
 }
}
