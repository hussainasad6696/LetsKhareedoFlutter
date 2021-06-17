import 'package:flutter/material.dart';
import 'package:letskhareedo/ModelView/ProductListViewModel.dart';
import 'package:provider/provider.dart';
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/WebServices/apis/api_response.dart';

import 'AllProductCardView.dart';

class AppProductGrid extends StatelessWidget {
  final String url;
  final String activity;

  const AppProductGrid({Key key, this.url, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse =
        Provider.of<ProductListViewModel>(context).response;

    if (url.isNotEmpty) {
      // Provider.of<ProductListViewModel>(context, listen: false).setSelectedProducts(null);
      Provider.of<ProductListViewModel>(context, listen: false)
          .fetchProducts(url);
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: getProductWidget(context, apiResponse),
    );
  }

  Widget getProductWidget(BuildContext context, ApiResponse apiResponse) {
    List<Products> productList = apiResponse.data as List<Products>;
    switch (apiResponse.status) {
      // case Status.LOADED:
      case Status.COMPLETED:
        return OrientationBuilder(
          builder: (context, orientation) {
            return GridView.builder(
                itemCount: productList.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.693,
                ),
                itemBuilder: (context, index) => AllProductsCard(
                      activity: activity,
                      products: productList[index],
                    ));
          },
        );
        break;
      case Status.LOADING:
        return Center(child: CircularProgressIndicator());
        break;
      case Status.ERROR:
        return Center(
          child: Text('Please try again latter!!!'),
        );
        break;
      case Status.INITIAL:
        return Center(child: Text("Loading..."));
        break;
    }
  }
}
