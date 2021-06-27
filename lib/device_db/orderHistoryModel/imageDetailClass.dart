import 'package:hive/hive.dart';

part 'ImageDetailClassDb.g.dart';

@HiveType(typeId: 3)
class ImageDetailClass extends HiveObject{

  @HiveField(0)
  final String imagePath;
  @HiveField(1)
  final String imageName;

  ImageDetailClass({this.imagePath,this.imageName});

  factory ImageDetailClass.fromJson(Map<dynamic,String> json){
    return ImageDetailClass(
        imagePath: "imagePath",
        imageName: "imageName"
    );
  }

  Object get typeId => 3;

}