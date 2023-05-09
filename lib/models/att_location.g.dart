// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'att_location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceLocationAdapter extends TypeAdapter<AttendanceLocation> {
  @override
  final int typeId = 3;

  @override
  AttendanceLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceLocation(
      id: fields[0] as int,
      name: fields[1] as String,
      polygonPoints: (fields[2] as List?)
          ?.map((dynamic e) => (e as List).cast<double>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceLocation obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.polygonPoints);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
