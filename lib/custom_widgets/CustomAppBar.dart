import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_svg/flutter_svg.dart';
import 'OptionMenuMobileAndWeb.dart';
import 'package:letskhareedo/constants/constant.dart';

class CustomAppBar extends StatelessWidget {
  String s;
  CustomAppBar({this.s});

  @override
  Widget build(BuildContext context) {
    String webCheck = kIsWeb ? WEB : MOBILE;
    return AppBar(
      bottomOpacity: webCheck == WEB ? 1.0 : 0.0,
      elevation: webCheck == WEB ? 1.0 : 0.0,

      // centerTitle: true,
      // backgroundColor: webCheck == WEB ? APP_BAR_BACKGROUND : APPLICATION_BACKGROUND_COLOR,
      title: TextButton(
        onPressed: () {
          print('letsKhareedo logo clicked'); //TODO logo click
        },
        child: Visibility(
          visible: s != "Sales" && s != "Cart",
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/letskhareedoLogo.jpeg'),
          ),
        ),
      ),
      leading: Visibility(
        visible: webCheck == MOBILE && s == "Sales" || s == "Cart" ? true : false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: SvgPicture.asset("assets/icons/back.svg"),
            onPressed: () {
              Navigator.pop(context);
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
            visible: s == "Sales" || s == "homePage",
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 0.0),
              child: IconButton(
                icon: SvgPicture.asset("assets/icons/bag.svg"),
                onPressed: () {
                  Navigator.pushNamed(context, "/AddToCartOrderView");
                },
                color: Colors.grey[800],
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
