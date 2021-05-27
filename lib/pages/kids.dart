import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/AppProductGridView.dart';


class KidsPage extends StatefulWidget {
  @override
  _KidsPageState createState() => _KidsPageState();
}

class _KidsPageState extends State<KidsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPLICATION_BACKGROUND_COLOR,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(8.0) ,
              child: Text("Male Kids"),),
            AppProductGrid(url: PRODUCTS_ADDRESS_MALE_KIDS, activity: "KidsPage",),
            Padding(padding: EdgeInsets.only(left: 8,right: 8,top: 8,bottom: 0) ,
            child: Text("Female Kids"),),
            Padding(padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Divider(
              color: Colors.black,
            ),),
            AppProductGrid(url: PRODUCTS_ADDRESS_FEMALE_KIDS, activity: "KidsPage",),
          ],
        ),
      )
    );
  }
}
