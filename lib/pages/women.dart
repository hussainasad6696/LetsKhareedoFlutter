import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/AppProductGridView.dart';

class WomenPage extends StatefulWidget {
  @override
  _WomenPageState createState() => _WomenPageState();
}

class _WomenPageState extends State<WomenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPLICATION_BACKGROUND_COLOR,
      body: AppProductGrid(url: PRODUCTS_ADDRESS_FEMALE_KIDS, activity: "WomenPage",),
    );
  }
}
