// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CartDB.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartDataBaseAdapter extends TypeAdapter<CartDataBase> {
  @override
  final int typeId = 0;

  @override
  CartDataBase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartDataBase(
      imageUrl: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as String,
      numberOfItems: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartDataBase obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.imageUrl)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.numberOfItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartDataBaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
