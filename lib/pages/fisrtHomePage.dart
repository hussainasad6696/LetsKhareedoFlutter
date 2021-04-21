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
                Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: CarouselSliderWeb()),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: cardViewWidget(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget cardViewWidget() {
    return GestureDetector(
      onTap: (){
      //TODO
      },
      child: Card(
        elevation: 20.0,
        color: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        child: SizedBox(
            height: 200,
            width: 150,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: AssetImage('assets/male.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            )),
      ),
    );
  }
}
