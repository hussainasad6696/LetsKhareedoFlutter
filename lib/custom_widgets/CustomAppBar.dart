import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';
import 'OptionMenuMobileAndWeb.dart';
import 'package:letskhareedo/constants/constant.dart';

class CustomAppBar extends StatefulWidget {
  String s;
  CustomAppBar({this.s});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  int numberOfItems = 0;

  listOfCartItems() async {
    numberOfItems = await HiveMethods().numberOfProductsInCart();
  }

  @override
  Widget build(BuildContext context) {
    String webCheck = kIsWeb ? WEB : MOBILE;
    return AppBar(
      bottomOpacity: webCheck == WEB ? 1.0 : 0.0,
      elevation: webCheck == WEB ? 1.0 : 0.0,

      // centerTitle: true,
      // backgroundColor: webCheck == WEB ? APP_BAR_BACKGROUND : APPLICATION_BACKGROUND_COLOR,

      leading: Visibility(
        visible: webCheck == MOBILE && widget.s == "Sales" || widget.s == "Cart" ? true : false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: SvgPicture.asset("assets/icons/back.svg"),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
      ),
      actions: <Widget>[
        Visibility(
          visible: webCheck == WEB,
          child: SizedBox(
            child: Categories(),
          ),
        ),
        Flexible(
          flex: 1,
          child: Visibility(
            visible: widget.s == "Sales" || widget.s == "homePage",
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
              child: Stack(
                children: [
                  IconButton(
                    icon: SvgPicture.asset("assets/icons/bag.svg"),
                    onPressed: () {
                      Navigator.pushNamed(context, "/AddToCartOrderView");
                    },
                    color: Colors.grey[800],
                  ),
                  Positioned(
                      right: 10,
                      top: 25,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6)
                        ),
                        constraints: BoxConstraints(
                          minHeight: 12,
                          minWidth: 12
                        ),
                        child: Text(
                          "$numberOfItems",
                          style: TextStyle(
                            fontSize: 12
                          ),
                        ),
                  ))
                ],
              ),
            ),
          ),
        ),
        Visibility(
            visible: widget.s == "Sales" || widget.s == "Cart" ? true : false,
            child: SizedBox(width: 10.0,))
      ],
    );
  }
}
