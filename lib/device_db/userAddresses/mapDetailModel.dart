import 'package:hive/hive.dart';

part 'MapDetailDb.g.dart';

@HiveType(typeId: 1)
class MapDetail {
  @HiveField(0)
  final String houseNumber;
  @HiveField(1)
  final String sector;
  @HiveField(2)
  final String street;
  @HiveField(3)
  final String city;
  @HiveField(4)
  final String floorNumber;
  @HiveField(5)
  final String label;

  MapDetail({this.city,this.floorNumber,this.houseNumber,this.label,this.sector,this.street});

  Object get typeId => 1;
}