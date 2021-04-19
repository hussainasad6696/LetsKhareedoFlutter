import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:letskhareedo/constants/constant.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    heightOfImageSlider = kIsWeb ? 500.0 : 200.0;
  }

  double heightOfImageSlider;

  static List<String> links = [
    "https://i.pinimg.com/originals/cc/18/8c/cc188c604e58cffd36e1d183c7198d21.jpg",
    "https://www.kyoceradocumentsolutions.be/blog/wp-content/uploads/2019/03/iStock-881331810.jpg",
    "https://resources.matcha-jp.com/resize/720x2000/2020/04/23-101958.jpeg"
  ];

  List<String> mainHeaders = ['Account', 'About Us', 'Contact Us', 'Blog'];
  List<String> categories = [
    'Home',
    'Store',
    'Kids',
    'Men',
    'Women',
    'Accessories'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: TextButton(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/letskhareedoLogo.jpeg'),
          ),
        ),
        actions: <Widget>[
          Padding(padding: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            onTap: (){
              print('u tapped cart in home');
            },
            child: Icon(
              Icons.shopping_cart,
              size: 26.0,
              color: Colors.grey[800],
            ),
          ),)
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
                                child: Image(
                                  image: AssetImage(
                                      'assets/letskhareedoLogo.jpeg'),
                                  fit: BoxFit.fill,
                                ));
                          },
                        );
                      }).toList(),
                    ),
                  )),
              SizedBox(
                height: 25.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) =>
                      buildCategory(index, categories),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategory(int index, List<String> categories) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(categories[index],
      style: TextStyle(
       fontWeight: FontWeight.bold,
       color: Colors.grey[1000]
      ),
      ),
    );
  }
}
