import 'package:flutter/material.dart';
import 'package:letskhareedo/ModelView/Model/ProductModel.dart';
import 'package:letskhareedo/constants/constant.dart';


class ProductCard extends StatelessWidget {
  final Products hotProducts;
  const ProductCard(this.hotProducts, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: SizedBox(
        width: 205,
        child: AspectRatio(
          aspectRatio: 1.83,
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
                        Text(hotProducts.name,
                          style: TextStyle(
                              color: Colors.black
                          ),),
                        SizedBox(height: 5,),
                        Text('${hotProducts.quantity}+ Products',
                          style: TextStyle(
                              color: kTextColor.withOpacity(0.6)
                          ),)
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 50,
                  child: AspectRatio(
                    aspectRatio: 1.15,
                    child: FadeInImage.assetNetwork(placeholder: "assets/icons/spinner.gif",
                        image: BASE_URL_HTTP_WITH_ADDRESS+PRODUCT_IMAGE_ADDRESS +hotProducts.imagePath),
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