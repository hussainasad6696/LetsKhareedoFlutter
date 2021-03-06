import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/device_db/CartDB.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';


class ProductSalesCard extends StatelessWidget {
  final CartDataBase cartDataBase;
  final int index;
  final int length;
  final HiveMethods hiveMethods;
  final Function(int) deleteItem;
  final bool dataFromClassFav;
  const ProductSalesCard(this.cartDataBase, this.index, this.length, this.dataFromClassFav, this.hiveMethods, {this.deleteItem,Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int _numberOfItems = 1;
    if(!dataFromClassFav)
    _numberOfItems = cartDataBase.numberOfItems;
    return favOrNotFav(context ,dataFromClassFav, _numberOfItems, cartDataBase);
  }

  Widget favOrNotFav(BuildContext context,bool favCheck, int _numberOfItems, CartDataBase products){
    if(favCheck){
      return GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, '/salesPage', arguments: {
            "price" : products.price,
            "description" : products.description,
            "imagePath" : products.imageUrl,
            "type" : products.type,
            "sizeType" : products.sizeType,
            "uuid" : products.uuid,
            "name" : products.name,
            "chest" : products.chest,
            "shoulder" : products.shoulder,
            "waist" : products.waist,
            "favCheck" : favCheck,
            "size" : products.size
          });
        },
        child: productCard(_numberOfItems),
      );
    }else return productCard(_numberOfItems);
  }

  Widget productCard(int _numberOfItems){
    return Visibility(
      visible: _numberOfItems != 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 90,
                  child: AspectRatio(
                    aspectRatio: 0.88,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.network(
                          BASE_URL_HTTP_WITH_ADDRESS+PRODUCT_IMAGE_ADDRESS+ cartDataBase.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartDataBase.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Rs ${cartDataBase.price}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${ cartDataBase.numberOfItems}",
                      style: TextStyle(color: kTextColor.withOpacity(0.8)),
                    ),
                    Text(
                      cartDataBase.description,
                      style: TextStyle(color: kTextColor.withOpacity(0.8)),
                    ),


                  ],
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(kPrimaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(RADIUS))),
                        ),
                        // hiveMethods.deleteFromList( index);

                        onPressed: () => deleteItem(index), child: Icon(
                        Icons.delete
                    )
                    ),
                  ),
                ),
              ],
            ),
            if( cartDataBase.waist != "")
              Visibility(
                  visible:  cartDataBase.waist != null,
                  child: Text("Waist: ${ cartDataBase.waist}")),
            Visibility(
                visible:  cartDataBase.sizeType != "",
                child: Text("Type: ${ cartDataBase.sizeType}  Chest: ${ cartDataBase.chest}  Shoulder: ${ cartDataBase.shoulder}"))
          ],
        ),
      ),
    );
  }
}
