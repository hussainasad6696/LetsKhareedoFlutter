import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class CarouselSliderWeb extends StatefulWidget {
  @override
  _CarouselSliderWebState createState() => _CarouselSliderWebState();
}

class _CarouselSliderWebState extends State<CarouselSliderWeb> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayAnimationDuration: Duration(microseconds: 800),
        autoPlay: true,
        height: 150.0
      ),items: [0,1,2,3,4,5].map((i){
      return Builder(builder: (BuildContext context){
        return Container(
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: (){
              //TODO
            },
            child: Image.network('https://picsum.photos/250?image=9'),
          ),
        );
      });
    }).toList(),
    );
  }
}
