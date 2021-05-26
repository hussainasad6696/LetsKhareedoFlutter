
import 'package:http/http.dart';
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/WebServices/WebServiceHttp.dart';
import 'package:connectivity/connectivity.dart';

class WebRepo {
  WebService _webService = WebService();

  Future<List<Products>> fetchProductList(String value) async{
    var connectionResult = await (Connectivity().checkConnectivity());
    if(connectionResult == ConnectivityResult.mobile){
      print("Connected to mobile network");
    }else print("Connected to wifi network");
    dynamic response = await _webService.getJson(value);
    print("response: $response");
    final jsonData = response as List;
    List<Products> productsList = jsonData.map((tagJson) => Products.fromJson(tagJson)).toList();
    return productsList;
  }
}