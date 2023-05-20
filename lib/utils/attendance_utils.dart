import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

int convertTimeToMin(int hour, int min) => hour * 60 + min;

String padZeros(int value) => value < 10 ? '0$value' : value.toString();

String getDayOfWeekString(int dayOfWeek) {
  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];
  return daysOfWeek[dayOfWeek - 1];
}

Future<Position> getCurrentLocation() async =>
    await Geolocator.getCurrentPosition();

DateTime customTime({
  required int hour,
  required int minute,
  int minToSubtract = 0,
  int minToAdd = 0,
}) {
  assert(minToAdd >= 0, "minToAdd must be greater than or equal to 0");
  assert(
      minToSubtract >= 0, "minToSubtract must be greater than or equal to 0");
  assert(minToAdd > 1 && minToSubtract < 1 || minToAdd < 1 && minToSubtract > 1,
      "Either minToAdd or minToSubtract can be greater than 0");

  DateTime now = DateTime.now();
  if (minToAdd > 0) {
    return DateTime(now.year, now.month, now.day, hour, minute)
        .add(Duration(minutes: minToAdd));
  }
  if (minToSubtract > 0) {
    return DateTime(now.year, now.month, now.day, hour, minute)
        .subtract(Duration(minutes: minToSubtract));
  }
  return DateTime(now.year, now.month, now.day, hour, minute);
}

//* The point-in-polygon algorithm
bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
  bool isInside = false;

  int numVertices = polygon.length;
  int j = numVertices - 1;

  for (int i = 0; i < numVertices; i++) {
    LatLng vertexI = polygon[i];
    LatLng vertexJ = polygon[j];

    //* Check if point is on edge of polygon
    if ((vertexI.longitude == point.longitude &&
            vertexI.latitude == point.latitude) ||
        (vertexJ.longitude == point.longitude &&
            vertexJ.latitude == point.latitude)) {
      return true;
    }

    //* Check if point is between vertices
    if ((vertexI.latitude < point.latitude &&
            vertexJ.latitude >= point.latitude) ||
        (vertexJ.latitude < point.latitude &&
            vertexI.latitude >= point.latitude)) {
      if (vertexI.longitude +
              (point.latitude - vertexI.latitude) /
                  (vertexJ.latitude - vertexI.latitude) *
                  (vertexJ.longitude - vertexI.longitude) <
          point.longitude) {
        isInside = !isInside;
      }
    }

    j = i;
  }

  return isInside;
}

// Time getMidTime({required Time startTime, required Time endTime}) {
//   int startTimeInMin = convertTimeToMin(startTime.hour, startTime.minute);
//   int endTimeInMin = convertTimeToMin(endTime.hour, endTime.minute);

//   int diffInMinutes = endTimeInMin - startTimeInMin;
//   int minutesToAdd = diffInMinutes ~/ 2;

//   int midTimeInMin = startTimeInMin + minutesToAdd;

//   return Time(midTimeInMin ~/ 60, midTimeInMin % 60);
// }
