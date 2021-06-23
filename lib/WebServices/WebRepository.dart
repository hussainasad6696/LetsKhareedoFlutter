
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/ModelView/Model/userprofile/userprofileModel.dart';
import 'package:letskhareedo/WebServices/WebServiceHttp.dart';
import 'package:connectivity/connectivity.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/device_db/CartDB.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';

class WebRepo {
  WebService _webService = WebService();

  Future<UserProfileModel> login(String number, String password) async {
    Map data = {"email": number, "password": password};
    Future<Response> response = _webService.postData(data, LOGIN_USER_ACCOUNT).then((value) {
      return value;
    });
    Response statusCode = await response.then((value) {
      return value;
    });
    statusCheck(statusCode);
    final parsed = jsonDecode(statusCode.body);
    final userData = UserProfileModel.fromJson(parsed);
    return userData;
  }

  Future<String> addNewUser(UserProfileModel userProfileModel) async {
    Future<Response> response = _webService.postData(userProfileModel.toJson(),ADD_NEW_USER).then((value) {
      return value;
    });
    Response statusCode = await response.then((value) {
      return value;
    });
    return statusCheck(statusCode);
  }

  Future<String> sendNewOrder(String cartData) async {
    String uuid = await HiveMethods().getUserPreferenceUuid();
    Map data = {
      "orderData" : cartData,
      "deviceId" : uuid
    };
    Future<Response> response = _webService.postData(data, SEND_NEW_ORDER);
    Response statusCode = await response.then((value) {
      return value;
    });
    return statusCheck(statusCode);
  }

  String statusCheck(Response status){
    final code = status.statusCode;
    if(code == 200) {
      Fluttertoast.showToast(msg: "Successful");
      return "Successful";
    } else if(code == 400) {
      Fluttertoast.showToast(msg: "Bad Request");
      return "Bad Request";
    } else if(code == 401 || code == 403) {
      Fluttertoast.showToast(msg: "Unauthorized");
      return "Unauthorized";
    } else if(code == 404) {
      Fluttertoast.showToast(msg: "Not found");
      return "Not found";
    } else if(code == 413) {
      Fluttertoast.showToast(msg: "Heavy payload");
      return "Heavy payload";
    } else if(code == 500) {
      Fluttertoast.showToast(msg: "User already exits");
      return "User already exits";
    } else {
      Fluttertoast.showToast(msg: "Server Communication failure");
      return "Server Communication failure";
    }
  }

  Future<List<String>> fetchPresentationImageList(String value) async {
    List<String> imageName = [];
    dynamic response = await _webService.getJson(value);
    final jsonData = response as List;
    jsonData.forEach((element) {
      imageName.add(element);
    });
    return imageName;
  }

  void internetConnectionCheck() async {
    var connectionResult = await (Connectivity().checkConnectivity());
    if(connectionResult == ConnectivityResult.mobile){
      print("Connected to mobile network");
    }else if(connectionResult == ConnectivityResult.wifi) print("Connected to wifi network");
    else Fluttertoast.showToast(msg: "No internet", toastLength: Toast.LENGTH_SHORT);
  }

  Future<List<Products>> fetchProductList(String value) async{
    internetConnectionCheck();
    dynamic response = await _webService.getJson(value);
    final jsonData = response as List;
    List<Products> productsList = jsonData.map((tagJson) => Products.fromJson(tagJson)).toList();
    return productsList;
  }

}