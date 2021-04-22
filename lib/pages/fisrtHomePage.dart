import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CarouselSliderForWeb.dart';
import 'package:letskhareedo/custom_widgets/CustomCardWidget.dart';

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
              Container(
                margin: EdgeInsets.all(5.0),
                child: SizedBox(
                  width: 205,
                  child: AspectRatio(
                    aspectRatio: 0.83,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Container(
                          color: Colors.amber,
                        ),
                        ClipPath(
                          clipper: CategoryCustomShape(),
                          child: AspectRatio(aspectRatio: 1.025,
                            child: Container(
                              color: kSecondaryColor,
                            ),),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ));
  }

}
class CategoryCustomShape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();

    double height = size.height;
    double width = size.width;
    double cornerSize = 30;

    path.lineTo(0, height - cornerSize);
    path.quadraticBezierTo(0, height, cornerSize, height);
    path.lineTo(width - cornerSize, height);
    path.quadraticBezierTo(width, height, width, height-cornerSize);
    path.lineTo(width, cornerSize);
    path.quadraticBezierTo(width, 0, width - cornerSize, 0);
    path.lineTo(cornerSize, cornerSize * 0.75);
    path.quadraticBezierTo(0, cornerSize, 0, cornerSize * 2);



    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}