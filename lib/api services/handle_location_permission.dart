import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print('Location services are disabled.');
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  print('Initial permission status: $permission');

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    print('Requested permission status: $permission');
    if (permission == LocationPermission.denied) {
      await Geolocator.openLocationSettings();
      print('Permission denied after request.');
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openAppSettings();
    print('Permission denied forever.');
    return Future.error('Location permissions are permanently denied.');
  }

  print('Permission granted, fetching position...');
  return await Geolocator.getCurrentPosition();
}
