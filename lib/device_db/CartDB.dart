
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

  CartDataBase(
      {this.imageUrl,
      this.name,
      this.description,
      this.price,
      this.numberOfItems});


}
