class Products {
  final String uuid;
  final String imagePath;
  final String price;
  final int quantity;
  final String description;
  final String material;
  final String brand;
  final String type;
  final String size;
  final String gender;
  final String kids;
  final bool hotOrNot;
  final String name;

  Products(
      {this.type,
      this.uuid,
      this.price,
      this.description,
      this.imagePath,
      this.brand,
      this.material,
      this.quantity,
      this.size,
      this.gender,
      this.kids,
      this.hotOrNot,
      this.name});

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        price: json["price"],
        description: json["description"],
        imagePath: json["imagePath"],
        brand: json["brand"],
        material: json["material"],
        quantity: json["quantity"],
        type: json["type"],
        uuid: json["_id"],
        size: json["size"],
        gender: json["gender"],
        kids: json["kids"],
        hotOrNot: json["hotOrNot"],
        name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "description": description,
      "imagePath": imagePath,
      "brand": brand,
      "material": material,
      "quantity": quantity,
      "type": type,
      "uuid": uuid,
      "size": size,
      "gender": gender,
      "ageGroup": kids,
      "hotOrNot": hotOrNot,
      "name": name
    };
  }
}
