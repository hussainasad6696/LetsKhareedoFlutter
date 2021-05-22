import 'package:flutter/material.dart';
import 'package:letskhareedo/constants/constant.dart';


class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: SizedBox(
        width: 205,
        child: AspectRatio(
          aspectRatio: 0.83,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ClipPath(
                clipper: CategoryCustomShape(),
                child: AspectRatio(aspectRatio: 1.025,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: kSecondaryColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('Demo',
                          style: TextStyle(
                              color: Colors.black
                          ),),
                        SizedBox(height: 5,),
                        Text('100+ Products',
                          style: TextStyle(
                              color: kTextColor.withOpacity(0.6)
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AspectRatio(
                    aspectRatio: 1.15,
                    child: FadeInImage.assetNetwork(placeholder: "assets/icons/spinner.gif",
                        image: BASE_URL_HTTP+"test.png"),
                        // image: "https://raw.githubusercontent.com/abuanwar072/furniture_app_flutter/master/assets/images/Item_2.png"),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class CategoryCustomShape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();

    double height = size.height;
    double width = size.width;
    double cornerSize = 30;

    path.lineTo(0, height - cornerSize);
    path.quadraticBezierTo(0, height, cornerSize, height);
    path.lineTo(width - cornerSize, height);
    path.quadraticBezierTo(width, height, width, height-cornerSize);
    path.lineTo(width, cornerSize);
    path.quadraticBezierTo(width, 0, width - cornerSize, 0);
    path.lineTo(cornerSize, cornerSize * 0.75);
    path.quadraticBezierTo(0, cornerSize, 0, cornerSize * 2);



    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}