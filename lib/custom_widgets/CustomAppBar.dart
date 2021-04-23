import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'OptionMenuMobileAndWeb.dart';
import 'package:letskhareedo/constants/constant.dart';

class CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    String webCheck = kIsWeb ? WEB : MOBILE;
    return AppBar(
      // bottomOpacity: webCheck == WEB ? 1.0 : 0.0,
      // elevation: webCheck == WEB ? 1.0 : 0.0,
      // centerTitle: true,
      // backgroundColor: webCheck == WEB ? APP_BAR_BACKGROUND : APPLICATION_BACKGROUND_COLOR,
        title: TextButton(
          onPressed: () {
            print('letsKhareedo logo clicked'); //TODO logo click
          },
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/letskhareedoLogo.jpeg'),
          ),
        ),
        actions: <Widget>[
          Visibility(
            visible: webCheck == WEB,
            child: SizedBox(
              width: 700.0,
              child: Categories(),
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.0,0.0,20.0,0.0),
              child: GestureDetector(
                onTap: () {
                  print('u tapped cart in home'); //TODO cart icon clicked
                },
                child: Icon(
                  Icons.shopping_cart,
                  size: 26.0,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
        ],
    );
  }
}
