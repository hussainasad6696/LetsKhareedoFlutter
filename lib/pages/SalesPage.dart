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

  Map selectedProductToBuy = {};
  String _selectedTypes = "";
  String _selectedChest = "";
  String _selectedShoulders = "";
  String _selectedWaist = "";
  bool _sizeVisibilityCheck = false;
  bool _waistVisibilityCheck = false;
  bool _guideArrowCheck = false;

  @override
  Widget build(BuildContext context) {
    selectedProductToBuy = selectedProductToBuy.isNotEmpty
        ? selectedProductToBuy
        : ModalRoute.of(context).settings.arguments;
    Products products = Products.fromJson(selectedProductToBuy);
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
      body: saleProductDetail(lightTextStyle, products),
    );
  }

  CartDataBase cartDataBase;

  @override
  void initState() {
    super.initState();
  }

  Widget saleProductDetail(TextStyle lightTextStyle, Products products) {
    List<String> _sizes = products.size.split(",");
    List<String> _chest = products.chest.split(",");
    List<String> _shoulders = products.shoulder.split(",");
    List<String> _waist = products.waist.split(",");
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
                          HiveMethods().addData(
                              products.imagePath,
                              products.name,
                              products.description,
                              products.price,
                              _numberOfItems,
                              _selectedShoulders,
                              _selectedChest,
                              _selectedTypes,
                          _selectedWaist);
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
        Visibility(
            visible: products.type != "shirt" || products.type != "Shirt",
            child: Text(
              "Waist",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ), ),
        SizedBox(
          height: 10,
        ),

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

        for (var i = 0; i < _sizes.length; i++)
          Visibility(
            visible: products.type == "shirt" || products.type == "Shirt",
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 40, child: Text(_sizes[i].toString())),
                  SizedBox(
                      height: 40, width: 70, child: Text(_chest[i].toString())),
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
              Text("Size: $_selectedTypes"),
              Text("Chest: $_selectedChest"),
              Text("Shoulder: $_selectedShoulders"),
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
