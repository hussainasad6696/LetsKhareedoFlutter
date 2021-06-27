import 'package:circulardropdownmenu/circulardropdownmenu.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
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

  Map selectedProductToBuy = {};
  String _selectedTypes = "";
  String _selectedChest = "";
  String _selectedShoulders = "";
  String _selectedWaist = "";
  bool _sizeVisibilityCheck = false;
  bool _waistVisibilityCheck = false;
  bool _guideArrowCheck = false;
  bool _checkOnce = false;

  @override
  Widget build(BuildContext context) {
    selectedProductToBuy = selectedProductToBuy.isNotEmpty
        ? selectedProductToBuy
        : ModalRoute.of(context).settings.arguments;
    Products products = Products.fromJson(selectedProductToBuy);
    String productUUid = selectedProductToBuy["uuid"];
    if(!_checkOnce) {
      favSelectedOrNot = selectedProductToBuy["favCheck"];
      _checkOnce = true;
    }
    HiveMethods hiveMethods = HiveMethods();

    TextStyle lightTextStyle = TextStyle(color: kTextColor.withOpacity(0.6));
    return Scaffold(
      backgroundColor: APPLICATION_BACKGROUND_COLOR,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(
            s: "Sales",
            drawerButtonClicked: (check) {
              if (!check) Navigator.pop(context);
            },
          )),
      body: saleProductDetail(lightTextStyle, products, productUUid, hiveMethods),
    );
  }

  CartDataBase cartDataBase;

  @override
  void initState() {
    super.initState();
  }

  List<String> _sizes;
  List<String> _chest;
  List<String> _shoulders;
  List<String> _waist;
  bool favSelectedOrNot = false;

  Widget saleProductDetail(TextStyle lightTextStyle, Products products, String productUUid, HiveMethods hiveMethods) {

    if (products.type == "shirt" || products.type == "Shirt") {
      _sizes = products.size.split(",");
      _chest = products.chest.split(",");
      _shoulders = products.shoulder.split(",");
    } else
      _waist = products.waist.split(",");

    return SingleChildScrollView(
      child: OrientationBuilder(builder: (context, orientation) {
        return SizedBox(
          width: double.infinity,
          height: orientation == Orientation.landscape
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.height -
                  AppBar().preferredSize.height,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 375,
                width: orientation == Orientation.landscape ? 350 : 150,
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
                          height: 20,
                        ),
                        productDetailSelector(
                            products, _sizes, _chest, _shoulders, _waist),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () async {
                        if (_numberOfItems > 0) {
                          var price =
                              double.parse(products.price) * _numberOfItems;
                          HiveMethods().addData(
                            CartDataBase(
                              imageUrl: products.imagePath,
                              name: products.name,
                              description: products.description,
                              price: price.toString(),
                              numberOfItems: _numberOfItems,
                              shoulder: _selectedShoulders,
                              chest: _selectedChest,
                              sizeType: _selectedTypes,
                              waist: _selectedWaist,
                              uuid: productUUid,
                              type: products.type
                            ));
                          Navigator.pushNamed(context, '/AddToCartOrderView');
                        } else {
                          setState(() {
                            _guideArrowCheck = true;
                          });
                          delayHandler();
                          Fluttertoast.showToast(msg: "Select quantity");
                        }
                      },
                      child: Text(
                        "Add to Cart >",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(kPrimaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(RADIUS))),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 345,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (favSelectedOrNot) {
                        favSelectedOrNot = false;
                        hiveMethods.deleteFromFav(productUUid);
                      } else {
                        favSelectedOrNot = true;
                        hiveMethods.addDataToFav(CartDataBase(
                          imageUrl: products.imagePath,
                          name: products.name,
                          description: products.description,
                          price: products.price,
                          numberOfItems: _numberOfItems,
                          shoulder: products.shoulder,
                          chest: products.chest,
                          waist: products.waist,
                          uuid: productUUid,
                          type: products.type,
                          size: products.size
                        ));
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: APPLICATION_BACKGROUND_COLOR,
                      child: Icon(
                              favSelectedOrNot
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            )
                      )
                    ),
                  ),
                ),
              Positioned(
                top: 55,
                right: 80,
                child: Container(
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _numberOfItems++;
                          });
                        },
                        iconSize: 20,
                        color: Colors.white,
                      ),
                      Text(
                        "$_numberOfItems",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_numberOfItems > 0) _numberOfItems--;
                          });
                        },
                        iconSize: 20,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _guideArrowCheck,
                child: Positioned(
                  top: 68,
                  right: 200,
                  child: Icon(
                    Icons.arrow_forward_outlined,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              Positioned(
                  top: 105,
                  right: -50,
                  child: Hero(
                    tag: "123",
                    child: Image.network(
                      BASE_URL_HTTP_WITH_ADDRESS +
                          PRODUCT_IMAGE_ADDRESS +
                          products.imagePath,
                      height: 318,
                      width: 304,
                      fit: BoxFit.cover,
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }

  Column productDetailSelector(Products products, List<String> _sizes,
      List<String> _chest, List<String> _shoulders, List<String> _waist) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: products.type == "shirt" || products.type == "Shirt",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Size",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Chest",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Shoulder",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        if (_waist != null)
          Visibility(
            visible: products.type != "shirt" || products.type != "Shirt",
            child: Text(
              "Waist",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        SizedBox(
          height: 10,
        ),
        if (_waist != null)
          for (var i = 0; i < _waist.length; i++)
            Visibility(
              visible: products.type != "shirt" || products.type != "Shirt",
              child: GestureDetector(
                child: SizedBox(height: 40, child: Text(_waist[i].toString())),
                onTap: () {
                  setState(() {
                    _waistVisibilityCheck = true;
                    _selectedWaist = "${_waist[i].toString()}";
                  });
                },
              ),
            ),
        if (_sizes != null)
          for (var i = 0; i < _sizes.length; i++)
            Visibility(
              visible: products.type == "shirt" || products.type == "Shirt",
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 40, child: Text(_sizes[i].toString())),
                    SizedBox(
                        height: 40,
                        width: 70,
                        child: Text(_chest[i].toString())),
                    SizedBox(
                        height: 40,
                        width: 50,
                        child: Text(_shoulders[i].toString())),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _sizeVisibilityCheck = true;
                    _selectedTypes = "${_sizes[i].toString()}";
                    _selectedChest = "${_chest[i].toString()}";
                    _selectedShoulders = "${_shoulders[i].toString()}";
                  });
                },
              ),
            ),
        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: _sizeVisibilityCheck,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Size: $_selectedTypes",
                style: TextStyle(color: kPrimaryColor),
              ),
              Text("Chest: $_selectedChest",
                  style: TextStyle(color: kPrimaryColor)),
              Text("Shoulder: $_selectedShoulders",
                  style: TextStyle(color: kPrimaryColor)),
            ],
          ),
        ),
        Visibility(
          visible: _waistVisibilityCheck,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Waist: $_selectedWaist"),
            ],
          ),
        )
      ],
    );
  }

  delayHandler() {
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        _guideArrowCheck = false;
      });
    });
  }
}
