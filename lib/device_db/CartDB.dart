
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
  final String sizeType;
  @HiveField(6)
  final String chest;
  @HiveField(7)
  final String shoulder;
  @HiveField(8)
  final String waist;
  @HiveField(9)
  final String uuid;
  @HiveField(10)
  final String type;
  @HiveField(11)
  final String size;

  CartDataBase(
      {this.imageUrl,
      this.name,
      this.description,
      this.price,
      this.numberOfItems,
      this.sizeType,
      this.chest,
      this.shoulder,
      this.waist,
      this.uuid,
      this.type,
      this.size});

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'name': name,
      'description': description,
      'price': price,
      'numberOfItems': numberOfItems,
      'sizeType' : sizeType,
      'chest': chest,
      'shoulder': shoulder,
      'waist': waist,
      'uuid' : uuid,
      'type' : type,
      'size' : size
    };
  }

}
