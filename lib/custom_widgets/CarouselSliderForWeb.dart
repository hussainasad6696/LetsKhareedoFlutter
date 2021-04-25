import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:letskhareedo/constants/constant.dart';

class CarouselSliderWeb extends StatefulWidget {
  @override
  _CarouselSliderWebState createState() => _CarouselSliderWebState();
}

class _CarouselSliderWebState extends State<CarouselSliderWeb> {

  static List<String> links = [
    'azizi.jpg',
    'demo1.jpeg',
    'demo2.jpeg'
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlay: true,
          height: webCheck == WEB ? 150.0 : 100.0),
      items: [0,1,2].map((i) {
        return Builder(builder: (BuildContext context) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            width: MediaQuery.of(context).size.width,
            child: GestureDetector(
              onTap: () {
                //TODO
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    BASE_URL+"${links[i]}",
                    fit: BoxFit.fill,
                  )),
            ),
          );
        });
      }).toList(),
    );
  }

  String webCheck;

  @override
  void initState() {
    super.initState();
    webCheck = kIsWeb ? WEB : MOBILE;
  }
}
