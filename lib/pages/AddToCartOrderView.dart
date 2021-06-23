import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:letskhareedo/WebServices/WebRepository.dart';
import 'package:letskhareedo/WebServices/WebServiceHttp.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/device_db/CartDB.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

int _numberOfItems = 1;

class _OrderViewState extends State<OrderView> {
  HiveMethods hiveMethods = HiveMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(s: "Cart", drawerButtonClicked: (check){
            if(!check)
            Navigator.pop(context);
          },)),
      body: Center(
        child: Column(
          children: [
            Text(
              "Your Cart",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            FutureBuilder(
              future: hiveMethods.getMeTheListNumberOfItemsInDb(),
              builder: (context,snapShot){
                return Text(
                "${snapShot.data} items",
                style:
                    TextStyle(fontSize: 12, color: kTextColor.withOpacity(0.6)),
              );
              }
            ),
            SizedBox(
              height: 30.0,
            ),
            Flexible(
              flex: 7,
                child: listOfProducts()),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: 50,
                      child: TextButton(
                        onPressed: () async {
                          List<CartDataBase> dataFromDataBase = await hiveMethods.getMeAllTheData();
                          var json = jsonEncode(dataFromDataBase.map((cartDatabase) => cartDatabase.toJson()).toList());
                          setState(()  {
                            // hiveMethods.deleteAll(DB_NAME);
                            WebRepo().sendNewOrder(json);
                          });
                        },
                        child: Text(
                          "Checkout >",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(kPrimaryColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(RADIUS))),
                        ),
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget listOfProducts() {
      return FutureBuilder(
        future: hiveMethods.getMeAllTheData(),
        builder: (context, snapShot){
          if(snapShot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapShot.data.length,
              itemBuilder: (context, index) {
                return productSalesCard(snapShot.data[index], index, snapShot.data.length);
              },
            );
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
  }


  Widget productSalesCard(CartDataBase cartDataBase, int index, length) {
    _numberOfItems = cartDataBase.numberOfItems;
    return Visibility(
      visible: _numberOfItems != 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: SizedBox(
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
                        BASE_URL_HTTP_WITH_ADDRESS+PRODUCT_IMAGE_ADDRESS+cartDataBase.imageUrl,
                        fit: BoxFit.cover,
                      ),
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
                  "${cartDataBase.numberOfItems}",
                  style: TextStyle(color: kTextColor.withOpacity(0.8)),
                ),
                Text(
                  cartDataBase.description,
                  style: TextStyle(color: kTextColor.withOpacity(0.8)),
                ),
                Text(
                  "Rs ${cartDataBase.price}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Visibility(
                    visible: cartDataBase.waist != null,
                    child: Text("Waist: ${cartDataBase.waist}")),
                Visibility(
                    visible: cartDataBase.type != "",
                    child: Text("Type: ${cartDataBase.type}  Chest: ${cartDataBase.chest}  Shoulder: ${cartDataBase.shoulder}"))
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
                    onPressed: (){
                      setState(() {
                        hiveMethods.deleteFromList(index);
                      });
                    }, child: Icon(
                  Icons.delete
                )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

  }
}
