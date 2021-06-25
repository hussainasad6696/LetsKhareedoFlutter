import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:letskhareedo/WebServices/WebRepository.dart';
import 'package:letskhareedo/WebServices/WebServiceHttp.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/custom_widgets/SelectedProductCard.dart';
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
                          // List<CartDataBase> dataFromDataBase = await hiveMethods.getMeAllTheData();
                          // var json = jsonEncode(dataFromDataBase.map((cartDatabase) => cartDatabase.toJson()).toList());
                          // setState(()  {
                          //   // hiveMethods.deleteAll(DB_NAME);
                          //   WebRepo().sendNewOrder(json);
                          // });
                          navigateToCheckOut();
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
                return ProductSalesCard(snapShot.data[index], index, snapShot.data.length, hiveMethods,
                deleteItem: (index){
                  setState(() {
                    hiveMethods.deleteFromList(index);
                  });
                },);
              },
            );
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
  }



  @override
  void initState() {
    super.initState();

  }

  void navigateToCheckOut() async {
    var obj = await Navigator.pushNamed(context, '/checkOut');
    setState(() {
      print("$obj");
    });
  }
}
