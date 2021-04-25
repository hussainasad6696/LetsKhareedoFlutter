import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';

class AllProductsCard extends StatelessWidget {

  final String url;
  final String activity;
  const AllProductsCard({
    Key key, this.url,
    this.activity
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('url: $url . activity: $activity');
        Navigator.pushNamed(context, '/salesPage');
      },
      child: Container(
        width: 145,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: FadeInImage.assetNetwork(placeholder: "assets/icons/spinner.gif",
                image: BASE_URL + "test.png",
                // image: "https://raw.githubusercontent.com/abuanwar072/furniture_app_flutter/master/assets/images/Item_1.png",
                fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Demo",style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(
              height: 5,
            ),
            Text("Rs 1000"),
          ],
        ),
      ),
    );
  }
}