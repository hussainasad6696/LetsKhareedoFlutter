import 'package:flutter/material.dart';
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/constants/constant.dart';

class AllProductsCard extends StatelessWidget {

  final String activity;
  final Products products;
  const AllProductsCard({
    Key key,
    this.activity, this.products
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/salesPage', arguments: {
          "product" : products
        });
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
                image: BASE_URL_HTTP+PRODUCT_IMAGE_ADDRESS + products.imagePath,
                // image: "https://raw.githubusercontent.com/abuanwar072/furniture_app_flutter/master/assets/images/Item_1.png",
                fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(products.name, style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(
              height: 5,
            ),
            Text(products.price),
          ],
        ),
      ),
    );
  }
}