import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:letskhareedo/constants/constant.dart';
import 'package:path_provider/path_provider.dart';

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
