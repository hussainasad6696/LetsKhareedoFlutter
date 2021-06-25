import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/AppProductGridView.dart';


class MenPage extends StatefulWidget {
  @override
  _MenPageState createState() => _MenPageState();
}

class _MenPageState extends State<MenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPLICATION_BACKGROUND_COLOR,
      body: AppProductGrid(url: PRODUCTS_ADDRESS_MALE, activity: "MenPage",favClicked: (){
        setState(() {
          print("standing here ----------------------");
        });
      },),
    );
  }
}
