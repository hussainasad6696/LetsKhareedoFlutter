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
      addressLine: fields[0] as String,
      city: fields[1] as String,
      floorNumber: fields[2] as String,
      label: fields[3] as String,
      latitude: fields[4] as double,
      longitude: fields[5] as double
    );
  }

  @override
  void write(BinaryWriter writer, MapDetail obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.addressLine)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.floorNumber)
      ..writeByte(3)
      ..write(obj.label)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude);
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
