
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/WebServices/WebServiceHttp.dart';
import 'package:connectivity/connectivity.dart';
import 'package:letskhareedo/constants/constant.dart';

class WebRepo {
  WebService _webService = WebService();

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