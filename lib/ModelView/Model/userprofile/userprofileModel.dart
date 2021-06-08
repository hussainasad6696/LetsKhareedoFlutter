import 'package:hive/hive.dart';

// part 'UserProfileDb.g.dart';

@HiveType(typeId: 1)
class UserProfileModel {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String phoneNumber;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String securityToken;
  @HiveField(6)
  final String profileImagePath;

  UserProfileModel(
      {this.userName,
      this.email,
      this.password,
      this.phoneNumber,
      this.address,
      this.securityToken,
      this.profileImagePath});

  factory UserProfileModel.fromJson(Map<String, dynamic> json){
    return UserProfileModel(
        userName: json['userName'],
        email: json['email'],
        password: json['password'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        securityToken: json['sercurityToken'],
        profileImagePath: json['profileImagePath']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'userName' : userName,
      'email' : email,
      'password' : password,
      'phoneNumber' : phoneNumber,
      'address' : address,
      'sercurityToken' : securityToken,
      'profileImagePath' : profileImagePath
    };
  }
}
