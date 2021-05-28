import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:letskhareedo/ModelView/ProductListViewModel.dart';
import 'package:letskhareedo/WebServices/WebRepository.dart';
import 'package:letskhareedo/WebServices/apis/api_response.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:provider/provider.dart';

import 'CarouselSliderForWeb.dart';

class CardWidget extends StatelessWidget {
  final VoidCallback onCardClicked;
  final Function(int) onCountChanged;
  double d;

  CardWidget(this.d, {this.onCardClicked, @required this.onCountChanged});

  @override
  Widget build(BuildContext context) {
    // ApiResponse _apiResponse = Provider.of<ProductListViewModel>(context).response;
    // Provider.of<ProductListViewModel>(context, listen: false).fetchSliderImage(ADVERTISEMENT_IMAGES_ADDRESS);

    return Padding(
        padding: EdgeInsets.only(left: ADD_CARD_PADDING, right: ADD_CARD_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: d, right: d),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      10.0, ADD_CARD_PADDING, 10.0, ADD_CARD_PADDING),
                  child: CarouselSliderWeb()),
            ),
            Center(
              child: OrientationBuilder(
                builder: (context, orientation) {
                  return FutureBuilder(
                    future: WebRepo()
                        .fetchPresentationImageList(ADVERTISEMENT_IMAGES_ADDRESS),
                    builder: (context, snapShot) {
                      if(snapShot.hasData) {
                        return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapShot.data.length,
                            shrinkWrap: true,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                              orientation == Orientation.portrait ? 2 : 4,
                              childAspectRatio: 0.693,
                            ),
                            itemBuilder: (context, index) {
                              return cardViewWidget(snapShot.data[index], index);
                            });
                      }else {
                        return Center(child: CircularProgressIndicator(),);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
    );
  }

  Widget cardViewWidget(String image, int index) {
    print("$image ------------------------------customCardWidget----");
    return GestureDetector(
      onTap: () {
        print('$image');
        //TODO
        onCountChanged(index);
        onCardClicked();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              bottom: -20,
              child: SizedBox(
                height: 35,
                width: 145,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(RADIUS),
                      bottomRight: Radius.circular(RADIUS)),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                          shadowColor: MaterialStateProperty.all(Colors.grey),
                          animationDuration: Duration(microseconds: 800)),
                      onPressed: () {
                        //TODO
                        print('$image');
                        onCardClicked();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: Text(
                            'Show Now',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )),
                ),
              ),
            ),
            Positioned(
              child: Card(
                elevation: 25.0,
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                child: SizedBox(
                    height: 200,
                    width: 150,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(RADIUS),
                        child: Image(
                          image: NetworkImage(BASE_URL_HTTP_WITH_ADDRESS+ADVERTISEMENT_IMAGES_SETTER_ADDRESS + image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
