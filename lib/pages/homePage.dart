import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';
import 'package:letskhareedo/ModelView/ProductListViewModel.dart';
import 'package:letskhareedo/WebServices/apis/api_response.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/constants/size_config.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/custom_widgets/CustomCardWidget.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';
import 'package:letskhareedo/device_db/sharedpref.dart';
import 'package:letskhareedo/pages/AccessoriesPage.dart';
import 'package:letskhareedo/pages/Store.dart';
import 'package:letskhareedo/pages/fisrtHomePage.dart';
import 'package:letskhareedo/pages/kids.dart';
import 'package:letskhareedo/pages/men.dart';
import 'package:letskhareedo/pages/women.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  HiveMethods hiveMethods = HiveMethods();
  SharedPrefs sharedPrefs = SharedPrefs();
  checkForUuid() async {
    bool check = await hiveMethods.userPreferenceUuidCheck();
    if (check) hiveMethods.userPreferencesUuid(Uuid().v4());
  }
  String userName;
  String userMail;
  bool loginStatus;
  @override
  void initState() {
    super.initState();
    heightOfImageSlider = kIsWeb ? 500.0 : 200.0;
    // webCheck = kIsWeb ? WEB : MOBILE;
    defaultSize = SizeConfig.defaultSize;
    checkForUuid();
    userName = sharedPrefs.getUserId();
    userMail = sharedPrefs.getUserMail();
    sharedPrefs.getLoginStatus();
    loginStatus = sharedPrefs.loginStatus();

    print("$userName :::::::::::::::: $userMail :::::::::::::::: $loginStatus");
  }

  double defaultSize;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  PageController _pageController = PageController(initialPage: 0);

  // String webCheck;
  double heightOfImageSlider;

  static List<String> links = ['azizi.jpg', 'demo1.jpeg', 'demo2.jpeg'];

  List<String> mainHeaders = ['Account', 'About Us', 'Contact Us', 'Blog'];

  int selectedIndex = 0;
  String _pageName = 'Home';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleHeading = TextStyle(color: Colors.white);
    TextStyle textStyleTiles = TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

    print("::::::::::::::::::::::::$userName ::::::::::$userMail:::::::::::::$loginStatus");
    return Scaffold(
        drawer: Container(
          width: 210,
          child: Drawer(
            child: Container(
              color: APPLICATION_DRAWER_COLOR,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  DrawerHeader(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: Text(
                            loginStatus == true && userName != "" ? userName[0].toUpperCase() : LETSKHAREEDO[0].toUpperCase(),
                            style: TextStyle(fontSize: 40.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          loginStatus == true && userName != "" ? userName : LETSKHAREEDO,
                          style: textStyleHeading,
                        ),
                        Text(
                          loginStatus == true && userMail != "" ? userMail : LETSKHAREEDO_MAIL,
                          style: textStyleHeading,
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person, color: Colors.white),
                        title: Text("Profile", style: textStyleTiles),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/profile', arguments: {
                            "loginStatus" : loginStatus,
                            "userName" : userName,
                            "userMail" : userMail
                          });
                          print("=----------------------------------------------------------------profile");
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.shopping_bag_outlined, color: Colors.white),
                        title: Text("Orders", style: textStyleTiles),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        title: Text("Fav", style: textStyleTiles),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                        title: Text("Address", style: textStyleTiles),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.logout,
                          color: Colors.red,
                        ),
                        title: Text("Logout", style: textStyleHeading),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        backgroundColor: APPLICATION_BACKGROUND_COLOR,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(PREFERRED_SIZE),
            child: CustomAppBar(s: "homePage")),
        body: webOrMobile()
        // ),
        );
  }

  List<Widget> uiColumn() {
    return [
      Visibility(
        visible: WEB_CHECK == WEB ? true : false,
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
          visible: WEB_CHECK == MOBILE,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, top: 5.0),
            child: Text(
              '$_pageName',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          )),
      Visibility(
        visible: WEB_CHECK == MOBILE,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: SizedBox(
            height: 25.0,
            child: optionMenuListView(),
          ),
        ),
      ),
      Expanded(child: pageView()),
    ];
  }

  Widget webOrMobile() {
    if (WEB_CHECK == WEB) {
      return ListView(
        children: uiColumn(),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: uiColumn(),
      );
    }
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
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: GestureDetector(
                    onTap: () {
                      print(
                          'image slider click detected ${i - 1}'); //TODO imageSlider clicked
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image(
                        // image: AssetImage(
                        //     'assets/letskhareedoLogo.jpeg'),
                        image: NetworkImage("$BASE_URL_HTTP" + links[i - 1]),
                        fit: BoxFit.fill,
                      ),
                    )));
          },
        );
      }).toList(),
    );
  }

  Widget pageView() {
    if (WEB_CHECK == MOBILE) {
      return PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: _onPageViewChange,
        children: [
          FirstHome(
            pageController: _pageController,
          ),
          Store(),
          Accessories(),
          KidsPage(),
          MenPage(),
          WomenPage()
        ],
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: CardWidget(
                300.0,
                onCountChanged: (index) {
                  //TODO
                  print('$index');
                },
                onCardClicked: () {
                  print('Call back selected');
                },
              ),
            )
          ],
        ),
      );
    }
    // return CarouselSliderWeb();
  }

  Widget optionMenuListView() {
    return ListView.builder(
      itemBuilder: (context, index) => buildCategory(index, categories),
      itemCount: categories.length,
      scrollDirection: Axis.horizontal,
    );
  }

  Widget buildCategory(int index, List<String> categories) {
    print('${WEB_CHECK == WEB}');
    if (WEB_CHECK == WEB) {
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
              _pageController.animateToPage(index,
                  curve: Curves.easeInOut,
                  duration: Duration(microseconds: 800));
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
