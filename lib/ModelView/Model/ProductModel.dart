
class Products {
  final String uuid;
  final String imagePath;
  final String price;
  final int quantity;
  final String description;
  final String material;
  final String brand;
  final Type type;

  Products({this.type,this.uuid,this.price,this.description,this.imagePath,this.brand,this.material,
  this.quantity});

  factory Products.fromJson(Map<String,dynamic> json){
    return Products(
      price: json["price"],
      description: json["description"],
      imagePath: json["image_path"],
      brand: json["brand"],
      material: json["material"],
      quantity: json["quantity"],
      type: Type.fromJson(json['type']),
      uuid: json["uuid"]
    );
  }
}

class Type {
  final Pant pant;
  final Shirt shirt;
  Type({this.pant,this.shirt});

  factory Type.fromJson(Map<String,dynamic> json){
    return Type(
      shirt: Shirt.fromJson(json['shirt']),
      pant: Pant.fromJson(json['pant'])
    );
  }

}

class Pant{
  final String waist;
  Pant({this.waist});

  factory Pant.fromJson(Map<String, dynamic> json){
    return Pant(
      waist: json["waist"]
    );
  }
}

class Shirt{
  final String size;
  Shirt({this.size});

  factory Shirt.fromJson(Map<String, dynamic> json){
    return Shirt(
      size: json["size"]
    );
  }

}