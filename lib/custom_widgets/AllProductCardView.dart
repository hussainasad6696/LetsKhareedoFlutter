import 'package:flutter/material.dart';
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';

class AllProductsCard extends StatelessWidget {

  final String activity;
  final Products products;
  final int index;
  const AllProductsCard({
    Key key,
    this.activity, this.products, this.index
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(products.imagePath != null)
    return Visibility(
      visible: products.imagePath != null,
      child: Container(
        width: 145,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            Stack(
              children: [

                GestureDetector(
                  onTap: (){
                    onItemSelected(context);
                  },
                  child: Center(
                    child: Container(
                      width: 140,
                      height: 150,
                      margin: EdgeInsets.only(top: 15),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: FadeInImage.assetNetwork(placeholder: "assets/icons/spinner.gif",
                          image: BASE_URL_HTTP_WITH_ADDRESS+PRODUCT_IMAGE_ADDRESS + products.imagePath,
                          fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),

              ],
            ),

            GestureDetector(
              onTap: (){
                onItemSelected(context);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(products.name, style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
                onTap: (){
                  onItemSelected(context);
                },
                child: Text(products.price)),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
                onTap: (){
                  onItemSelected(context);
                },
                child: Text("Quantity: ${products.quantity}")),
          ],
        ),
      ),
    );
    else return Visibility(
        visible: false,
        child: Text(""));
  }

  onItemSelected(BuildContext context) async {
    bool favCheck = await HiveMethods().checkForExistance(products.uuid).then((value) {
    return value;
    });
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
      "waist" : products.waist,
      "favCheck" : favCheck
    });
  }
}