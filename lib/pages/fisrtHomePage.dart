
import 'package:flutter/material.dart';
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/ModelView/ProductListViewModel.dart';
import 'package:letskhareedo/WebServices/apis/api_response.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomCardWidget.dart';
import 'package:letskhareedo/custom_widgets/ProductCardView.dart';
import 'package:provider/provider.dart';

class FirstHome extends StatefulWidget {

  PageController pageController;
  FirstHome({this.pageController});

  @override
  _FirstHomeState createState() => _FirstHomeState(pageController);
}

class _FirstHomeState extends State<FirstHome> {

  final PageController pageController;
  _FirstHomeState(this.pageController);


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ApiResponse _apiResponse = Provider.of<ProductListViewModel>(context).response;
    Provider.of<ProductListViewModel>(context, listen: false).fetchProducts(PRODUCT_HOT_OR_NOT);
    return Scaffold(
        backgroundColor: APPLICATION_BACKGROUND_COLOR,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardWidget(
                0.0,
                onCardClicked: (){
                print('firstHomePage clicked');
                // pageController.jumpToPage(4);
              },
                onCountChanged: (index){
                pageController.animateToPage(index, curve: Curves.easeInOut, duration: Duration(microseconds: 800));
                },
              ),
              Padding(padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Text(
                  "Hot Products",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Categories(_apiResponse))
            ],
          )
        ));
  }

}

class Categories extends StatelessWidget {
  final ApiResponse apiResponse;
  const Categories(this.apiResponse, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Products> getMeAllTheHotProducts = apiResponse.data as List<Products>;
    return OrientationBuilder(
      builder: (context , orientation){
        return GridView.builder(
            itemCount: getMeAllTheHotProducts.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
            ),
            itemBuilder: (context, index) {
              return ProductCard(getMeAllTheHotProducts[index]);
            });
      },
    );
      // ProductCard(); //TODO
  }
}

