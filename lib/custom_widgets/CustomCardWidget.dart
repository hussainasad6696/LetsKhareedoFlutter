import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';

import 'CarouselSliderForWeb.dart';

class CardWidget extends StatelessWidget {
  static List<String> images = ['male.jpeg', 'female.jpeg'];

  final VoidCallback onCardClicked;
  final Function(int) onCountChanged;
  double d;
  CardWidget(this.d, {this.onCardClicked, @required this.onCountChanged});

  @override
  Widget build(BuildContext context) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(ADD_CARD_PADDING),
                child: cardViewWidget(images[0]),
              ),
              Padding(
                padding: EdgeInsets.all(ADD_CARD_PADDING),
                child: cardViewWidget(images[1]),
              ),
              Visibility(
                  visible: WEB_CHECK == WEB,
                  child: Padding(
                    padding: EdgeInsets.all(ADD_CARD_PADDING),
                    child: cardViewWidget(images[1]),
                  )),
              Visibility(
                  visible: WEB_CHECK == WEB,
                  child: Padding(
                    padding: EdgeInsets.all(ADD_CARD_PADDING),
                    child: cardViewWidget(images[1]),
                  )),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: WEB_CHECK == MOBILE,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: Padding(
                      padding: EdgeInsets.all(ADD_CARD_PADDING),
                      child: cardViewWidget(images[0]),
              ),
                  )),
              Visibility(
                  visible: WEB_CHECK == MOBILE,
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                    child: Padding(
                      padding: EdgeInsets.all(ADD_CARD_PADDING),
                      child: cardViewWidget(images[1]),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget cardViewWidget(String image) {
    return GestureDetector(
      onTap: () {
        print('$image');
        //TODO
        onCountChanged(image == images[0] ? 4 : 5);
        onCardClicked();
      },
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
                        image: NetworkImage("$BASE_URL_HTTP"+image),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
