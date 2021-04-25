import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:letskhareedo/custom_widgets/CustomAppBar.dart';


class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}


int _numberOfItems = 1;

class _OrderViewState extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(PREFERRED_SIZE),
          child: CustomAppBar(s : "Cart")),
      body: Center(
            child: Column(
              children: [
                Text("Your Cart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16
                ),),
                Text("4 items",
                style: TextStyle(
                  fontSize: 12,
                  color: kTextColor.withOpacity(0.6)
                ),),
                SizedBox(height: 30.0,),
                productSalesCard(),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
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
                                    borderRadius:
                                    BorderRadius.circular(RADIUS))),
                          ),
                        ),
                      ),
                    )
                  ),
                )
              ],
            ),

      ),
    );
  }

  Widget productSalesCard() {
    double width = MediaQuery.of(context).size.width;

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
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Image.network(BASE_URL+"test.png", fit: BoxFit.cover,),
                            ),
                          ),
                        ),
                           Padding(
                            padding: const EdgeInsets.only(left:20.0, right: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Text("Denim", style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),),
                                Text("Description", style: TextStyle(
                                  color: kTextColor.withOpacity(0.8)
                                ),),
                                Text("Rs 1000",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),)
                              ],
                            ),
                          ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(left: width -330),
                        child: Row(
                          children: [
                            IconButton(icon: Icon(
                                Icons.add
                            ), onPressed: (){
                              setState(() {
                                _numberOfItems++;
                              });
                            },
                            iconSize: 20,),
                            Text("$_numberOfItems",
                            style: TextStyle(
                              fontSize: 20
                            ),),
                            IconButton(icon: Icon(
                              Icons.remove
                            ), onPressed: (){
                             setState(() {
                               _numberOfItems--;
                             });
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
