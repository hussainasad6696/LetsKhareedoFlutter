import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Categories extends StatefulWidget {


  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {



  List<String> categories = [
    'Home',
    'Store',
    'Accessories',
    'Kids',
    'Men',
    'Women',
  ];
  String webCheck;

  @override
  void initState() {
    super.initState();
    webCheck = kIsWeb ? WEB : MOBILE;
  }

  @override
  Widget build(BuildContext context) {
    return   ListView.builder(
        itemBuilder: (context, index) =>
            buildCategory(index, categories),
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
          )
      );
    }
  }
}


