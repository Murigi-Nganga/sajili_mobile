import 'package:get/get.dart';
import 'package:location/location.dart';

// Controller for the 'moving' GPS location - with phone
//TODO: Look at how to track location over a period of time
class GPSController extends GetxController {
  final Location _location = Location();
  Rx<LocationData?> location = Rx<LocationData?>(null);

  @override
  void onInit() {
    super.onInit();
    _location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 5000,
      distanceFilter: 2
    );
    _location.onLocationChanged.listen(
        (LocationData currentLocation) => location.value = currentLocation);
  }
}
