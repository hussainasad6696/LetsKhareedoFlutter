import 'package:circulardropdownmenu/circulardropdownmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'dart:developer';

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  String _dropDownMenuData = "32";

  @override
  Widget build(BuildContext context) {
    TextStyle lightTextStyle = TextStyle(color: kTextColor.withOpacity(0.6));
    log("base url is $BASE_URL"+"test.png");
    return Scaffold(
      backgroundColor: APPLICATION_BACKGROUND_COLOR,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(
            s: "Sales",
          )),
      body: SingleChildScrollView(
        child: saleProductDetail(lightTextStyle),
      ),
    );
  }

  OrientationBuilder saleProductDetail(TextStyle lightTextStyle) {
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
                        "Pant".toUpperCase(),
                        style: lightTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Denim Cotton Pant",
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
                        "Rs 1000",
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
                      )
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
                          "Denim Cotton Pant",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Description Description Description Description Description",
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
                              onPressed: () {},
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
                  top: 95,
                  right: -50,
                  child: Hero(
                    tag: "123",
                    child: Image.network(
                      BASE_URL + "test.png",
                      // "https://raw.githubusercontent.com/abuanwar072/furniture_app_flutter/master/assets/images/Item_1.png",
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
