import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CarouselSliderForWeb.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/custom_widgets/OptionMenuMobileAndWeb.dart';
import 'package:letskhareedo/pages/AccessoriesPage.dart';
import 'package:letskhareedo/pages/Store.dart';
import 'package:letskhareedo/pages/fisrtHomePage.dart';
import 'package:letskhareedo/pages/kids.dart';
import 'package:letskhareedo/pages/men.dart';
import 'package:letskhareedo/pages/women.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    heightOfImageSlider = kIsWeb ? 500.0 : 200.0;
    webCheck = kIsWeb ? WEB : MOBILE;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  PageController _pageController = PageController(initialPage: 0);
  String webCheck;
  double heightOfImageSlider;

  static List<String> links = [
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9',
    'https://picsum.photos/250?image=9'
  ];

  List<String> mainHeaders = ['Account', 'About Us', 'Contact Us', 'Blog'];

  int selectedIndex = 0;
  String _pageName = 'Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPLICATION_BACKGROUND_COLOR,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Visibility(
            visible: webCheck == WEB ? true : false,
            child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Container(
                    height: heightOfImageSlider,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: carouselSliderForWeb())),
          ),
          Visibility(
              visible: webCheck == MOBILE,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 5.0),
                child: Text(
                  '$_pageName',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              )),
          Visibility(
            visible: webCheck == MOBILE,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: SizedBox(
                height: 25.0,
                child: optionMenuListView(),
              ),
            ),
          ),
          Expanded(child: pageView())
        ],
      ),
    );
  }

  _onPageViewChange(int index) {
    print('$index');
    setState(() {
      selectedIndex = index;
      _pageName = categories[index];
    });
  }

  List<String> categories = [
    'Home',
    'Store',
    'Accessories',
    'Kids',
    'Men',
    'Women',
  ];

  Widget carouselSliderForWeb() {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: [links.length].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: GestureDetector(
                  onTap: () {
                    print(
                        'image slider click detected ${i - 1}'); //TODO imageSlider clicked
                  },
                  child: Image(
                    // image: AssetImage(
                    //     'assets/letskhareedoLogo.jpeg'),
                    image: NetworkImage(links[i - 1]),
                    fit: BoxFit.fill,
                  ),
                ));
          },
        );
      }).toList(),
    );
  }

  Widget pageView() {
    if (webCheck == MOBILE) {
      return PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: _onPageViewChange,
        children: [
          FirstHome(),
          Store(),
          Accessories(),
          KidsPage(),
          MenPage(),
          WomenPage()
        ],
      );
    }else return CarouselSliderWeb();
  }

  Widget optionMenuListView() {
    return ListView.builder(
      itemBuilder: (context, index) => buildCategory(index, categories),
      itemCount: categories.length,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget buildCategory(int index, List<String> categories) {
    print('${webCheck == WEB}');
    if (webCheck == WEB) {
      return TextButton(
          onPressed: () {
            print('${categories[index]}'); //TODO
          },
          child: Text(
            '${categories[index]}',
            style: TextStyle(
                color: Colors.black,
                letterSpacing: 1,
                wordSpacing: 5,
                fontWeight: FontWeight.bold),
          ));
    } else {
      return GestureDetector(
          onTap: () {
            setState(() {
              print('$selectedIndex - ${categories[index]}');
              _pageController.jumpToPage(index);
              _pageName = categories[index];
            });
          },
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    categories[index],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedIndex == index
                            ? Colors.grey[1000]
                            : Colors.grey[500]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.0 / 4),
                    height: 2,
                    width: 20,
                    color: selectedIndex == index
                        ? Colors.black
                        : Colors.transparent,
                  )
                ],
              )));
    }
  }
}
