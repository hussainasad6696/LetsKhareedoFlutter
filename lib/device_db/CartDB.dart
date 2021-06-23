
import 'package:hive/hive.dart';

part 'CartDB.g.dart';

@HiveType(typeId: 0)
class CartDataBase {
  @HiveField(0)
  final String imageUrl;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String price;
  @HiveField(4)
   int numberOfItems;
  @HiveField(5)
  final String type;
  @HiveField(6)
  final String chest;
  @HiveField(7)
  final String shoulder;
  @HiveField(8)
  final String waist;

  CartDataBase(
      {this.imageUrl,
      this.name,
      this.description,
      this.price,
      this.numberOfItems,
      this.type,
      this.chest,
      this.shoulder,
      this.waist});

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'description': description,
      'price': price,
      'numberOfItems': numberOfItems,
      'type' : type,
      'chest': chest,
      'shoulder': shoulder,
      'waist': waist
    };
  }

}
