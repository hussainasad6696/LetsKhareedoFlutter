import 'package:letskhareedo/ModelView/Model/ProductModel.dart';

class OrderList {
  final String date;
  final Products products;
  final String bill;
  final String status;

  OrderList({this.date, this.products, this.bill, this.status});

  factory OrderList.fromJson(Map<String, dynamic> json) {
    return OrderList(
        date: json["date"],
        products: json["products"],
        bill: json["bill"],
        status: json["status"]);
  }

  Map<String, dynamic> toJson() {
    return {"date": date, "products": products, "bill": bill, "status": status};
  }
}

class UserProfileModel {
  final String name;
  final String email;
  final String password;
  final OrderList orderList;
  final String phoneNumber;
  final String address;
  final String profileImageByteStream;
  final String profileImageName;
  final String verificationStatus;
  final String verificationCode;

  UserProfileModel(
      {this.name,
      this.email,
      this.password,
      this.orderList,
      this.phoneNumber,
      this.address,
        this.profileImageName,
      this.profileImageByteStream,
      this.verificationStatus,
      this.verificationCode});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        orderList: json['orderList'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        profileImageName: json['profileImageName'],
        profileImageByteStream: json['profileImagePath'],
        verificationStatus: json['verificationStatus'],
        verificationCode: json['verificationCode']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'orderList': orderList,
      'phoneNumber': phoneNumber,
      'profileImageName' : profileImageName,
      'address': address,
      'profileImagePath': profileImageByteStream,
      'verificationStatus': verificationStatus,
      'verificationCode': verificationCode
    };
  }
}
