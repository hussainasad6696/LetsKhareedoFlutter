
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/ModelView/Model/userprofile/userprofileModel.dart';
import 'package:letskhareedo/WebServices/WebServiceHttp.dart';
import 'package:connectivity/connectivity.dart';
import 'package:letskhareedo/constants/constant.dart';

class WebRepo {
  WebService _webService = WebService();

  Future<String> login(String number, String password) async {
    Map data = {"phoneNumber": number, "password": password};
    Future<Response> response = _webService.postData(data, LOGIN_USER_ACCOUNT).then((value) {
      return value;
    });
    Response statusCode = await response.then((value) {
      return value;
    });
    return statusCheck(statusCode);
  }

  Future<String> addNewUser(UserProfileModel userProfileModel) async {
    Future<Response> response = _webService.postData(userProfileModel.toJson(),ADD_NEW_USER).then((value) {
      return value;
    });
    Response statusCode = await response.then((value) {
      return value;
    });
    print("Status check +++++++++++++++++++++++++++${statusCode.statusCode}");
    return statusCheck(statusCode);
  }

  String statusCheck(Response status){
    final code = status.statusCode;
    if(code == 200) return "Successful";
    else if(code == 400) return "Bad Request";
    else if(code == 401 || code == 403) return "Unauthorized";
    else if(code == 404) return "Not found";
    else if(code == 413) return "Heavy payload";
    else if(code == 500) return "User already exits";
    else return "Server Communication failure";
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
    print("response: $response");
    final jsonData = response as List;
    List<Products> productsList = jsonData.map((tagJson) => Products.fromJson(tagJson)).toList();
    return productsList;
  }

}