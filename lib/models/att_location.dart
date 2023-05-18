import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

part 'att_location.g.dart';

@HiveType(typeId: 3)
class AttendanceLocation {
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<LatLng>? polygonPoints;

  AttendanceLocation({
    required this.id,
    required this.name,
    this.polygonPoints,
  });

  factory AttendanceLocation.fromJson(Map<String, dynamic> data) =>
      AttendanceLocation(
        id: data['id'],
        name: data['name'],
        //? Convert the string to a list of LatLng objects
        polygonPoints: data['polygon_points'] == null
            ? null
            : (json.decode(data['polygon_points']) as List<dynamic>)
                .map((point) => LatLng(point[0], point[1]))
                .toList(),
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
