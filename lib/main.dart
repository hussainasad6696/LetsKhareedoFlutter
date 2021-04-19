

import 'package:flutter/material.dart';
import 'package:letskhareedo/pages/home.dart';
import 'package:letskhareedo/pages/splashScreen.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/' : (context) => SplashScreen(),
      '/home' : (context) => Home()
    },
  ));
}

