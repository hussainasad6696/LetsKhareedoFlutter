// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderHistoryClass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************


class OrderHistoryAdapter extends TypeAdapter<OrderHistoryDetailClass> {
  @override
  final int typeId = 1;

  @override
  OrderHistoryDetailClass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderHistoryDetailClass(
      imageDetail: fields[0] as List<ImageDetailClass>,
      price: fields[1] as double,
      date: fields[2] as DateTime
    );
  }

  @override
  void write(BinaryWriter writer, OrderHistoryDetailClass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.imageDetail)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is OrderHistoryDetailClass &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
