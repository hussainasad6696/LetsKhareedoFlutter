import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';


class MenPage extends StatefulWidget {
  @override
  _MenPageState createState() => _MenPageState();
}

class _MenPageState extends State<MenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPLICATION_BACKGROUND_COLOR,
      body: Text(
        'Men'
      ),
    );
  }
}
