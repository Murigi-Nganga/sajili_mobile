import 'package:hive/hive.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TimeAdapter extends TypeAdapter<Time> {
  @override
  int get typeId => 127;

  @override
  Time read(BinaryReader reader) {
    final hour = reader.readByte();
    final minute = reader.readByte();
    final second = reader.readByte();
    return Time(hour, minute, second);
  }

  @override
  void write(BinaryWriter writer, Time obj) {
    writer.writeByte(obj.hour);
    writer.writeByte(obj.minute);
    writer.writeByte(obj.second);
  }
}
