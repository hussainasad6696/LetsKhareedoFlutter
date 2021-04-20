import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/OptionMenuMobileAndWeb.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    heightOfImageSlider = kIsWeb ? 500.0 : 200.0;
    webCheck = kIsWeb ? WEB : MOBILE;
  }

  String webCheck;
  double heightOfImageSlider;

  static List<String> links = [
    "https://i.pinimg.com/originals/cc/18/8c/cc188c604e58cffd36e1d183c7198d21.jpg",
    "https://www.kyoceradocumentsolutions.be/blog/wp-content/uploads/2019/03/iStock-881331810.jpg",
    "https://resources.matcha-jp.com/resize/720x2000/2020/04/23-101958.jpeg"
  ];

  List<String> mainHeaders = ['Account', 'About Us', 'Contact Us', 'Blog'];


  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: TextButton(
          onPressed: () {
            print('letsKhareedo logo clicked'); //TODO logo click
          },
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/letskhareedoLogo.jpeg'),
          ),
        ),
        actions: <Widget>[
          Visibility(
            visible: webCheck == WEB,
            child: SizedBox(
              width: 700.0,
              child: Categories(),
              // ListView.builder(
              //   itemBuilder: (context, index) =>
              //
              //   itemCount: categories.length,
              //   scrollDirection: Axis.horizontal,
              // ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                print('u tapped cart in home'); //TODO cart icon clicked
              },
              child: Icon(
                Icons.shopping_cart,
                size: 26.0,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Container(
                    height: heightOfImageSlider,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        enlargeCenterPage: true,
                        autoPlay: true,
                      ),
                      items: [0, 1, 2].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    print(
                                        'image slider click detected'); //TODO imageSlider clicked
                                  },
                                  child: Image(
                                    image: AssetImage(
                                        'assets/letskhareedoLogo.jpeg'),
                                    fit: BoxFit.fill,
                                  ),
                                ));
                          },
                        );
                      }).toList(),
                    ),
                  )),
              Visibility(
                  visible: webCheck == MOBILE,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Divider(
                      height: 20,
                      color: Colors.black,
                    ),
                  )),
              Visibility(
                visible: webCheck == MOBILE,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: SizedBox(
                    height: 25.0,
                      child: Categories(),
                      // child: ListView.builder(
                      //   scrollDirection: Axis.horizontal,
                      //   itemCount: categories.length,
                      //   itemBuilder: (context, index) =>
                      //       buildCategory(index, categories, webCheck),
                      // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildCategory(int index, List<String> categories) {
  //   print('${webCheck == WEB}');
  //   if (webCheck == WEB) {
  //     return TextButton(
  //         onPressed: () {
  //           print('${categories[index]}'); //TODO
  //         },
  //         child: Text(
  //           '${categories[index]}',
  //           style: TextStyle(
  //               color: Colors.black,
  //               letterSpacing: 1,
  //               wordSpacing: 5,
  //               fontWeight: FontWeight.bold),
  //         ));
  //   } else {
  //     return GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             selectedIndex = index;
  //           });
  //         },
  //         child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text(
  //                   categories[index],
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       color: selectedIndex == index
  //                           ? Colors.grey[1000]
  //                           : Colors.grey[500]),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(top: 15.0 / 4),
  //                   height: 2,
  //                   width: 20,
  //                   color: selectedIndex == index
  //                       ? Colors.black
  //                       : Colors.transparent,
  //                 )
  //               ],
  //             )));
  //   }
  // }
}
