import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';
import 'package:letskhareedo/device_db/sharedpref.dart';
import 'package:letskhareedo/map/maps.dart';
import 'package:letskhareedo/pages/AccessoriesPage.dart';
import 'package:letskhareedo/pages/AddToCartOrderView.dart';
import 'package:letskhareedo/pages/SalesPage.dart';
import 'package:letskhareedo/pages/Store.dart';
import 'package:letskhareedo/pages/fisrtHomePage.dart';
import 'package:letskhareedo/pages/homePage.dart';
import 'package:letskhareedo/pages/kids.dart';
import 'package:letskhareedo/pages/men.dart';
import 'package:letskhareedo/pages/profile/Profile.dart';
import 'package:letskhareedo/pages/splashScreen.dart';
import 'package:letskhareedo/pages/women.dart';
import 'package:provider/provider.dart';

import 'ModelView/ProductListViewModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveMethods().init();
  BaseSharedPreference.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: ProductListViewModel()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme:
              GoogleFonts.dmSansTextTheme().apply(displayColor: kTextColor),
          appBarTheme: AppBarTheme(
              color: Colors.transparent, brightness: Brightness.light),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/fistHomePage': (context) => FirstHome(),
        '/Store': (context) => Store(),
        '/AccessoriesPage': (context) => Accessories(),
        '/kids': (context) => KidsPage(),
        '/men': (context) => MenPage(),
        '/women': (context) => WomenPage(),
        '/salesPage': (context) => Sales(),
        '/AddToCartOrderView': (context) => OrderView(),
        '/profile': (context) => Profile(),
        '/map' : (context) => Maps()
      },
    ),
  ));
}
