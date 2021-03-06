import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:letskhareedo/WebServices/WebRepository.dart';
import 'package:letskhareedo/constants/constant.dart';

class CarouselSliderWeb extends StatefulWidget {
  @override
  _CarouselSliderWebState createState() => _CarouselSliderWebState();
}

class _CarouselSliderWebState extends State<CarouselSliderWeb> {



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: WebRepo().fetchPresentationImageList(SLIDER_IMAGE_ADDRESS),
      builder: (context, snapShot){
        if(snapShot.hasData) {
            return CarouselSlider(
              options: CarouselOptions(
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlay: true,
                  height: webCheck == WEB ? 150.0 : 100.0),
              items: [0, 1, 2].map((i) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0)),
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: () {
                        //TODO
                      },
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            BASE_URL_HTTP_WITH_ADDRESS +
                                SLIDER_IMAGE_SETTER_ADDRESS +
                                snapShot.data[i],
                            fit: BoxFit.fill,
                          )),
                    ),
                  );
                });
              }).toList(),
            );
          }else return Center(child: CircularProgressIndicator(),);
        }

    );
  }

  String webCheck;
  @override
  void initState() {
    super.initState();
    webCheck = kIsWeb ? WEB : MOBILE;
  }
}
