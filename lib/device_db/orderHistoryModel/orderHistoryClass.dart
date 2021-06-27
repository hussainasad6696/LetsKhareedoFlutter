
import 'package:hive/hive.dart';

import 'imageDetailClass.dart';

part 'OrderHistoryDetailClassDb.g.dart';

@HiveType(typeId: 2)
class OrderHistoryDetailClass{

  @HiveField(0)
  final HiveList<ImageDetailClass> imageDetail;
  @HiveField(1)
  final double price;
  @HiveField(2)
  final DateTime date;

  OrderHistoryDetailClass({this.price,this.imageDetail,this.date});

  Object get typeId => 2;

}