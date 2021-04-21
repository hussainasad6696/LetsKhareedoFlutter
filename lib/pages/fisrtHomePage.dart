import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CarouselSliderForWeb.dart';


class FirstHome extends StatefulWidget {
  @override
  _FirstHomeState createState() => _FirstHomeState();
}

class _FirstHomeState extends State<FirstHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPLICATION_BACKGROUND_COLOR,
      body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              child: CarouselSliderWeb()
            )
          ],
        ),
      ),
      )
    );
  }
}
