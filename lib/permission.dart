import 'package:permission_handler/permission_handler.dart';


class PermissionsControl{
  static Future<PermissionStatus> requestLocationPermission()async{
    var status = await Permission.location.status;
    if(status.isDenied){
      status = await Permission.location.request();
    }
    return status;
  }
}