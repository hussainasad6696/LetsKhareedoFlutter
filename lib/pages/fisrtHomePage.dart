
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/constants/size_config.dart';
import 'package:letskhareedo/custom_widgets/CarouselSliderForWeb.dart';
import 'package:letskhareedo/custom_widgets/CustomCardWidget.dart';
import 'package:letskhareedo/custom_widgets/ProductCardView.dart';

class FirstHome extends StatefulWidget {

  PageController pageController;
  FirstHome({this.pageController});

  @override
  _FirstHomeState createState() => _FirstHomeState(pageController);
}

class _FirstHomeState extends State<FirstHome> {

  final PageController pageController;
  _FirstHomeState(this.pageController);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: APPLICATION_BACKGROUND_COLOR,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardWidget(
                0.0,
                onCardClicked: (){
                print('firstHomePage clicked');
                // pageController.jumpToPage(4);
              },
                onCountChanged: (index){
                pageController.animateToPage(index, curve: Curves.easeInOut, duration: Duration(microseconds: 800));
                },
              ),
              Padding(padding: EdgeInsets.all(20.0),
                child: Text(
                  "Hot Products",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Categories()
            ],
          )
        ));
  }

}

class Categories extends StatelessWidget {
  const Categories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          ProductCard(), //TODO
          ProductCard(),
          ProductCard(),
          ProductCard(),
        ],
      ),
    );
  }
}

