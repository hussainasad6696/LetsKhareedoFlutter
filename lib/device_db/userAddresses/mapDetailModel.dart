import 'package:hive/hive.dart';

part 'MapDetailDb.g.dart';

@HiveType(typeId: 1)
class MapDetail {
  @HiveField(0)
  final String addressLine;
  @HiveField(3)
  final String city;
  @HiveField(4)
  final String floorNumber;
  @HiveField(5)
  final String label;
  @HiveField(6)
  final double latitude;
  @HiveField(7)
  final double longitude;

  MapDetail(
      {this.city,
      this.floorNumber,
      this.addressLine,
      this.label,
      this.longitude,
      this.latitude});

  Object get typeId => 1;
}
