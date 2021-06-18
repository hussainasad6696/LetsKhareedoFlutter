
import 'package:circulardropdownmenu/circulardropdownmenu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'dart:developer';

import 'package:letskhareedo/device_db/CartDB.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {

  int _numberOfItems = 0;
  String _dropDownMenuData = "32";

  Map selectedProductToBuy = {};

  @override
  Widget build(BuildContext context) {

    selectedProductToBuy = selectedProductToBuy.isNotEmpty ? selectedProductToBuy : ModalRoute.of(context).settings.arguments;
    Products products = Products.fromJson(selectedProductToBuy);
    TextStyle lightTextStyle = TextStyle(color: kTextColor.withOpacity(0.6));
    return Scaffold(
      backgroundColor: APPLICATION_BACKGROUND_COLOR,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(
            s: "Sales",
            drawerButtonClicked: (check){
              if(!check)
                Navigator.pop(context);
            },
          )),
      body: SingleChildScrollView(
        child: saleProductDetail(lightTextStyle, products),
      ),
    );
  }

  CartDataBase cartDataBase;

  @override
  void initState(){
  super.initState();
  }

  OrientationBuilder saleProductDetail(TextStyle lightTextStyle, Products products) {
    return OrientationBuilder(builder: (context, orientation) {
        return SizedBox(
          width: double.infinity,
          height: orientation == Orientation.landscape ?
              MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 375,
                width: orientation == Orientation.landscape? 350 : 150,
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        products.type.toUpperCase(),
                        style: lightTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        products.name,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.8,
                            height: 1.4),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "For",
                        style: lightTextStyle,
                      ),
                      Text(
                        "Rs ${products.price}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            height: 1.6),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Available Selection",
                        style: lightTextStyle,
                      ),
                      CircularDropDownMenu(
                        dropDownMenuItem: [
                          DropdownMenuItem(
                            child: GestureDetector(
                              onTap: () {},
                              child: Text('32'),
                            ),
                            value: '32',
                          ),
                          DropdownMenuItem(
                            child: GestureDetector(
                              onTap: () {},
                              child: Text('42'),
                            ),
                            value: '42',
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dropDownMenuData = value;
                          });
                        },
                        hintText: _dropDownMenuData,
                      ),

                    ],
                  ),
                ),
              ),
              Positioned(
                top: 375,
                left: 0,
                right: 0,
                child: Container(
                  constraints: BoxConstraints(minHeight: 440),
                  padding: EdgeInsets.only(top: 90, left: 20, right: 20),
                  // height: 500,
                  decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          products.name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          products.description,
                          style: TextStyle(
                              color: kTextColor.withOpacity(0.7), height: 1.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextButton(
                              onPressed: () async {
                                if(_numberOfItems > 0) {
                                HiveMethods().addData(
                                    products.imagePath,
                                    products.name,
                                    products.description,
                                    products.price,
                                    _numberOfItems);
                                Navigator.pushNamed(
                                    context, '/AddToCartOrderView');
                              }else Fluttertoast.showToast(msg: "Select quantity");
                            },
                              child: Text(
                                "Add to Cart",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(kPrimaryColor),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(RADIUS))),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 55,
                right: 80,
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Row(
                  children: [
                    IconButton(icon: Icon(
                        Icons.add
                    ), onPressed: (){
                      setState(() {
                        _numberOfItems++;
                      });
                    },
                      iconSize: 20,
                    color: Colors.white,),
                    Text("$_numberOfItems",
                      style: TextStyle(
                          fontSize: 20,
                        color: Colors.white
                      ),),
                    IconButton(icon: Icon(
                        Icons.remove
                    ), onPressed: (){
                      setState(() {
                        if(_numberOfItems > 0)
                        _numberOfItems--;
                      });
                    }, iconSize: 20,
                    color: Colors.white,)
                  ],
              ),
                ),),
              Positioned(
                  top: 95,
                  right: -50,
                  child: Hero(
                    tag: "123",
                    child: Image.network(
                      BASE_URL_HTTP_WITH_ADDRESS+PRODUCT_IMAGE_ADDRESS + products.imagePath,
                      height: 378,
                      width: 364,
                      fit: BoxFit.cover,
                    ),
                  ))
            ],
          ),
        );
      });
  }
}
