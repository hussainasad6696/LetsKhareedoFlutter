
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/pages/AccessoriesPage.dart';
import 'package:letskhareedo/pages/Store.dart';
import 'package:letskhareedo/pages/fisrtHomePage.dart';
import 'package:letskhareedo/pages/homePage.dart';
import 'package:letskhareedo/pages/kids.dart';
import 'package:letskhareedo/pages/men.dart';
import 'package:letskhareedo/pages/splashScreen.dart';
import 'package:letskhareedo/pages/women.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'LetsKhareedo',
    theme: ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.dmSansTextTheme().apply(displayColor: kTextColor),
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        brightness: Brightness.light
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity
    ),
    initialRoute: '/',
    routes: {
      '/' : (context) => SplashScreen(),
      '/home' : (context) => HomePage(),
      '/fistHomePage' : (context) => FirstHome(),
      '/Store' : (context) => Store(),
      '/AccessoriesPage' : (context) => Accessories(),
      '/kids' : (context) => KidsPage(),
      '/men' : (context) => MenPage(),
      '/women' : (context) => WomenPage()
    },
  ));
}

