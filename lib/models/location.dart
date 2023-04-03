class AttendanceLocation {
  int id;
  String name;
  double? centreLat;
  double? centreLong;
  double? radius;

  AttendanceLocation({
    required this.id,
    required this.name,
    this.centreLat,
    this.centreLong,
    this.radius,
  });

  factory AttendanceLocation.fromJson(Map<String, dynamic> json) =>
      AttendanceLocation(
        id: json['id'],
        name: json['name'],
        centreLat: json['centre_lat'],
        centreLong: json['centre_long'],
        radius: json['radius'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'centreLat': centreLat,
        'centreLong': centreLong,
        'radius': radius,
      };

  @override
  String toString() {
    return name;
  }
}
