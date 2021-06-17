import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';
import 'OptionMenuMobileAndWeb.dart';
import 'package:letskhareedo/constants/constant.dart';

class CustomAppBar extends StatelessWidget {
  final String s;
  CustomAppBar({this.s,this.drawerButtonClicked});

  int numberOfItems = 0;

 final Function drawerButtonClicked;
  listOfCartItems() async {
    numberOfItems = await HiveMethods().numberOfProductsInCart();
  }
  String HOME_PAGE = "homePage";
  @override
  Widget build(BuildContext context) {
    String webCheck = kIsWeb ? WEB : MOBILE;
    return AppBar(
      bottomOpacity: webCheck == WEB ? 1.0 : 0.0,
      elevation: webCheck == WEB ? 1.0 : 0.0,

      leading: IconButton(icon: s == HOME_PAGE ?
       Icon(Icons.menu, color: Colors.black,) :
          Icon(Icons.arrow_back, color: Colors.black,)
        , onPressed: () => drawerButtonClicked(),),
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
            visible: s == "Sales" || s == HOME_PAGE,
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
            visible: s == "Sales" || s == "Cart" ? true : false,
            child: SizedBox(width: 10.0,))
      ],
    );
  }
}
