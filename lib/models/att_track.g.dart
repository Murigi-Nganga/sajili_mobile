// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'att_track.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendanceTrackAdapter extends TypeAdapter<AttendanceTrack> {
  @override
  final int typeId = 7;

  @override
  AttendanceTrack read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendanceTrack(
      btnOnePressed: fields[0] as bool,
      btnTwoPressed: fields[1] as bool,
      btnThreePressed: fields[2] as bool,
      btnOneInLocation: fields[3] as bool,
      btnTwoInLocation: fields[4] as bool,
      btnThreeInLocation: fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AttendanceTrack obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.btnOnePressed)
      ..writeByte(1)
      ..write(obj.btnTwoPressed)
      ..writeByte(2)
      ..write(obj.btnThreePressed)
      ..writeByte(3)
      ..write(obj.btnOneInLocation)
      ..writeByte(4)
      ..write(obj.btnTwoInLocation)
      ..writeByte(5)
      ..write(obj.btnThreeInLocation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendanceTrackAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
