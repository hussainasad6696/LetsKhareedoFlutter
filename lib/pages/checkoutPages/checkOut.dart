import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:letskhareedo/WebServices/WebRepository.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/custom_widgets/SelectedProductCard.dart';
import 'package:letskhareedo/device_db/CartDB.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';
import 'package:letskhareedo/device_db/orderHistoryModel/imageDetailClass.dart';
import 'package:letskhareedo/device_db/orderHistoryModel/orderHistoryClass.dart';


class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    double totalCost = 0.0;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(s: "", drawerButtonClicked: (check){
            if(!check)
              Navigator.pop(context);
          },)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                    future: HiveMethods().getMeTheListNumberOfItemsInDb(),
                    builder: (context,snapShot){
                  return Text("${snapShot.data} Items", style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),);
                }),

                IconButton(
                    onPressed: () async {
                      setState(() {
                        HiveMethods().deleteAll(DB_NAME);
                      });
                    },
                    icon: Icon(Icons.delete_outline, color: Colors.grey[700],))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 34.0),
            child: Divider(thickness: 2,),
          ),
          Flexible(
              flex: 7,
              child: listOfProducts()),

          Padding(
            padding: const EdgeInsets.only(left: 28.0, right: 34.0),
            child: Divider(thickness: 2,),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total", style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),),
                FutureBuilder(
                  future: HiveMethods().getMeTheTotalCostOfSelectedProducts(),
                  builder: (context,snapShot) {
                    totalCost = snapShot.data;
                  return Text("Rs: ${snapShot.data}",style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),);
                }
                )
              ],
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () async {
                        List<CartDataBase> dataFromDataBase = await HiveMethods().getMeAllTheData();
                        var imageDetail = [];
                        DateTime now = new DateTime.now();
                        DateTime date = new DateTime(now.year,now.month,now.day);
                        await dataFromDataBase.forEach((element) {
                         imageDetail.add(ImageDetailClass(
                           imageName: element.name,
                           imagePath: element.imageUrl
                         ));
                        });
                        OrderHistoryDetailClass orderData = OrderHistoryDetailClass(
                          imageDetail: imageDetail,
                          date: date,
                          price: totalCost
                        );
                        var json = jsonEncode(dataFromDataBase.map((cartDatabase) => cartDatabase.toJson()).toList());
                        setState(()  {
                          HiveMethods().addDataToOrder(orderData);
                          WebRepo().sendNewOrder(json);
                        });
                      },
                      child: Text(
                        "Buy Now",
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
    );
  }

  Widget listOfProducts() {
    HiveMethods hiveMethods = HiveMethods();
    return FutureBuilder(
      future: hiveMethods.getMeAllTheData(),
      builder: (context, snapShot){
        if(snapShot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: snapShot.data.length,
            itemBuilder: (context, index) {
              return ProductSalesCard(
                  snapShot.data[index], index, snapShot.data.length,
                false,
                hiveMethods, deleteItem: (index){
                    setState(() {
                      hiveMethods.deleteFromList(index,DB_NAME);
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
}
