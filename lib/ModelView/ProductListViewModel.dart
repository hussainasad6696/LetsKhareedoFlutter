import 'package:flutter/cupertino.dart';
import 'package:letskhareedo/WebServices/WebRepository.dart';
import 'package:letskhareedo/WebServices/apis/api_response.dart';

import 'Model/ProductModel.dart';

class ProductListViewModel with ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  Products _products;

  ApiResponse get response {
    return _apiResponse;
  }

  Products get product {
    return _products;
  }

  Future<void> fetchProducts(String val) async {
    // markAsLoading();
    try {
      List<Products> products = await WebRepo().fetchProductList(val);
      print("${products.length} =============viewModel");
      _apiResponse = ApiResponse.completed(products);
      // _apiResponse = ApiResponse.loaded("Data Loaded");
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print("productViewModel: " + e.toString());
    }
      notifyListeners();
  }

  void setSelectedProducts(Products products) {
    _products = products;
    notifyListeners();
  }

  void markAsLoading() {
    _apiResponse = ApiResponse.loading('Fetching product data');
    notifyListeners();
  }
}
