// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapDetailModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************


class MapDetailAdapter extends TypeAdapter<MapDetail> {
  @override
  final int typeId = 1;

  @override
  MapDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MapDetail(
      houseNumber: fields[0] as String,
      sector: fields[1] as String,
      street: fields[2] as String,
      city: fields[3] as String,
      floorNumber: fields[4] as String,
      label: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MapDetail obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.houseNumber)
      ..writeByte(1)
      ..write(obj.sector)
      ..writeByte(2)
      ..write(obj.street)
      ..writeByte(3)
      ..write(obj.city)
      ..writeByte(4)
      ..write(obj.floorNumber)
      ..writeByte(5)
      ..write(obj.label);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MapDetail &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
