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
          "price" : products.price,
          "description" : products.description,
          "imagePath" : products.imagePath,
          "brand" : products.brand,
          "material" : products.material,
          "quantity" : products.quantity,
          "type" : products.type,
          "uuid" : products.uuid,
          "size" : products.size,
          "gender" : products.gender,
          "ageGroup" : products.kids,
          "hotOrNot" : products.hotOrNot,
          "name" : products.name,
          "chest" : products.chest,
          "shoulder" : products.shoulder,
          "waist" : products.waist
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
                image: BASE_URL_HTTP_WITH_ADDRESS+PRODUCT_IMAGE_ADDRESS + products.imagePath,
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
            SizedBox(
              height: 5,
            ),
            Text("Quantity: ${products.quantity}"),
          ],
        ),
      ),
    );
  }
}