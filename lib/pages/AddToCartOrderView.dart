import 'package:flutter/material.dart';
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
          child: CustomAppBar(s: "Cart")),
      body: Center(
        child: Column(

          children: [
            Text(
              "Your Cart",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              "4 items",
              style:
                  TextStyle(fontSize: 12, color: kTextColor.withOpacity(0.6)),
            ),
            SizedBox(
              height: 30.0,
            ),
            Flexible(
              flex: 7,
                child: listOfProducts()),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            hiveMethods.deleteAll(DB_NAME);
                          });
                        },
                        child: Text(
                          "Book Order",
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
      // Future<List<CartDataBase>> list = HiveMethods().getMeAllTheData();
      return FutureBuilder(
        future: hiveMethods.getMeAllTheData(),
        builder: (context, snapShot){
          if(snapShot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapShot.data.length,
              itemBuilder: (context, index) {
                return productSalesCard(snapShot.data[index], index);
              },
            );
          }else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
  }


  Widget productSalesCard(CartDataBase cartDataBase, int index) {
    _numberOfItems = cartDataBase.numberOfItems;
    return Visibility(
      visible: _numberOfItems != 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: AspectRatio(
                aspectRatio: 0.88,
                child: Container(
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 5.0),
              child: Column(
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
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0),
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
