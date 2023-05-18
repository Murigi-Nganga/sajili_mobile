import 'package:hive/hive.dart';

part 'att_track.g.dart';

@HiveType(typeId: 7)
class AttendanceTrack {
  @HiveField(0)
  bool btnOnePressed;

  @HiveField(1)
  bool btnTwoPressed;

  @HiveField(2)
  bool btnThreePressed;

  @HiveField(3)
  bool btnOneInLocation;

  @HiveField(4)
  bool btnTwoInLocation;

  @HiveField(5)
  bool btnThreeInLocation;

  AttendanceTrack({
    this.btnOnePressed = false,
    this.btnTwoPressed = false,
    this.btnThreePressed = false,
    this.btnOneInLocation = false,
    this.btnTwoInLocation = false,
    this.btnThreeInLocation = false,
  });

  Map<String, dynamic> toJson() => {
    "buttonOnePressed": btnOnePressed,
    "buttonTwoPressed": btnTwoPressed,
    "buttonThreePressed": btnThreePressed,
    "buttonOneInLocation": btnOneInLocation,
    "buttonTwoInLocation": btnTwoInLocation,
    "buttonThreeInLocation": btnThreeInLocation
  };
}
