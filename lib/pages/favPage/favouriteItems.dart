import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';
import 'package:letskhareedo/custom_widgets/SelectedProductCard.dart';
import 'package:letskhareedo/device_db/CartDB.dart';
import 'package:letskhareedo/device_db/hive/HiveMethods.dart';


class FavouriteItems extends StatefulWidget {
  const FavouriteItems({Key key}) : super(key: key);

  @override
  _FavouriteItemsState createState() => _FavouriteItemsState();
}

class _FavouriteItemsState extends State<FavouriteItems> {
  @override
  Widget build(BuildContext context) {
    HiveMethods hiveMethods = HiveMethods();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(
            s: "Favourite",
            drawerButtonClicked: (check){
              if(!check) Navigator.pop(context);
            },
          )),
      body: buildFutureBuilder(hiveMethods),
    );
  }

  FutureBuilder<List<CartDataBase>> buildFutureBuilder(HiveMethods hiveMethods) {
    return FutureBuilder(
          future: hiveMethods.getAllTheFavData(),
          builder: (context,snapShot){
            if(snapShot.hasData){
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapShot.data.length,
                  itemBuilder: (context, index){
                  return ProductSalesCard(snapShot.data[index],
                    index, snapShot.data.length, true,
                    hiveMethods,
                  deleteItem: (index){
                    setState(() {
                      hiveMethods.deleteFromList(index,DB_FAV_NAME);
                    });
                  },
                );
              });
            }else return Center(child: CircularProgressIndicator());
          },
        );
  }
}
