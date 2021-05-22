
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/WebServices/WebServiceHttp.dart';

class WebRepo {
  WebService _webService = WebService();

  Future<List<Products>> fetchProductList(String value) async{
    dynamic response = await _webService.getJson(value);
    final jsonData = response['results'] as List;
    List<Products> productsList = jsonData.map((tagJson) => Products.fromJson(tagJson)).toList();
    return productsList;
  }
}