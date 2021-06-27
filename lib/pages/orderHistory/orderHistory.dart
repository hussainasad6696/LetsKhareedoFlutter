import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';
import 'package:letskhareedo/device_db/orderHistoryModel/orderHistoryClass.dart';


class OrderHistory extends StatefulWidget {
  const OrderHistory({Key key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(s: "Orders History", drawerButtonClicked: (check){
            if(!check)
              Navigator.pop(context);
          },)),
      body: FutureBuilder(
          future: HiveMethods().getAllTheOrderData(),
          builder: (context, snapShot){
          if(snapShot.hasData){
            return GridView.builder(
                itemCount: snapShot.data.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.693,
                ),
                itemBuilder: (context,index){
              return historyCard(snapShot.data[index]);
                });
          }else return CircularProgressIndicator();
      }),
    );
  }

  Widget historyCard(OrderHistoryDetailClass orderHistoryDetailClass){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(RADIUS)
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),

        ),
      ),
    );
  }
}
