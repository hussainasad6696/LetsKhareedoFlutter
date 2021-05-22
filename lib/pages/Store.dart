import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/AppProductGridView.dart';


class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPLICATION_BACKGROUND_COLOR,
      body: AppProductGrid(url: PRODUCTS_ADDRESS_STORE, activity: "Store", )
    );
  }
}




