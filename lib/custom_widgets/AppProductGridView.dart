import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/size_config.dart';

import 'AllProductCardView.dart';

class AppProductGrid extends StatelessWidget {
  final String url;
  final String activity;
  const AppProductGrid({
    Key key, this.url , this.activity
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: OrientationBuilder(
        builder: (context, orientation){
          return GridView.builder(
              itemCount: 4,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.693,
              ),
              itemBuilder: (context, index) => AllProductsCard(url: url, activity: activity, name: "Denim",)
          );
        },
      ),
    );
  }
}