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
  int selectedIndex = 0;

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
              selectedIndex = index;
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


