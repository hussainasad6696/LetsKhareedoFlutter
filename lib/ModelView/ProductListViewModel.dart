import 'package:flutter/cupertino.dart';
import 'package:letskhareedo/WebServices/WebRepository.dart';
import 'package:letskhareedo/WebServices/apis/api_response.dart';

import 'Model/ProductModel.dart';

class ProductListViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');
  WebRepo _webRepo = WebRepo();
  Products _products;

  ApiResponse get response {
    return _apiResponse;
  }

  Products get product {
    return _products;
  }

  Future<void> fetchProducts(String val) async {
    // markAsLoading();
    _apiResponse = ApiResponse.loading('Fetching product data');
    try {
      List<Products> products = await _webRepo.fetchProductList(val);
      print("${products.length} =============viewModel");
      _apiResponse = ApiResponse.completed(products);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print("productViewModel: " + e.toString());
    }
      notifyListeners();
  }

  Future<void> fetchSliderImage(String url) async {
    _apiResponse = ApiResponse.loading("Fetching product data");
    try{
      List<String> images = await _webRepo.fetchPresentationImageList(url);
      _apiResponse = ApiResponse.completed(images);
    }catch (e){
      _apiResponse = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  void setSelectedProducts(Products products) {
    _products = products;
    notifyListeners();
  }

  // void markAsLoading() {
  //   _apiResponse = ApiResponse.loading('Fetching product data');
  //   notifyListeners();
  // }
}
