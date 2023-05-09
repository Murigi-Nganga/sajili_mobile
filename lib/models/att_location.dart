import 'dart:convert';
import 'package:hive/hive.dart';

part 'att_location.g.dart';

@HiveType(typeId: 3)
class AttendanceLocation {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<List<double>>? polygonPoints;

  AttendanceLocation({
    required this.id,
    required this.name,
    this.polygonPoints,
  });

  factory AttendanceLocation.fromJson(Map<String, dynamic> data) =>
      AttendanceLocation(
        id: data['id'],
        name: data['name'],
        polygonPoints: data['polygon_points'] == null
            ? null
            : (json.decode(data['polygon_points']) as List<List<double>>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'polygon_points': polygonPoints,
      };

  @override
  String toString() {
    return name;
  }
}
