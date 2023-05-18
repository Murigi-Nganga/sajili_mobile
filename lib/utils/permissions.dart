import 'package:permission_handler/permission_handler.dart';

//* Request for permissions if not granted
Future<void> requestPermissions() async {
  await [
    Permission.location,
    Permission.camera,
    Permission.notification
  ].request();
}