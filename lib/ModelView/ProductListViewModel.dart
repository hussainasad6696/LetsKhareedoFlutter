
import 'package:flutter/cupertino.dart';
import 'package:letskhareedo/WebServices/WebRepository.dart';
import 'package:letskhareedo/WebServices/apis/api_response.dart';

import 'Model/ProductModel.dart';

class ProductListViewModel with ChangeNotifier{
    ApiResponse _apiResponse = ApiResponse.loading("Fetching artist data");

    Products _products;

    ApiResponse get response {
      return _apiResponse;
    }
    Products get product{
      return _products;
    }
    Future<void> fetchProducts(String val) async {
      _apiResponse = ApiResponse.loading('Fetching artist data');
      notifyListeners();
    try{
      List<Products> products = await WebRepo().fetchProductList(val);
      _apiResponse = ApiResponse.completed(products);
    }catch(e){
      _apiResponse = ApiResponse.error(e.toString());
      print("productViewModel"+e.toString());
    }
      notifyListeners();
    }

    void setSelectedProducts(Products products){
      _products = products;
      notifyListeners();
    }
}