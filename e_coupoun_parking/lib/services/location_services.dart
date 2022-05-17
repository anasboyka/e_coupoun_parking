import 'package:geolocator/geolocator.dart';

class LocationServices {
  Position? position;
  LocationServices({
    this.position,
  });

  Future<Position?> initPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      print('no permission');
      return null;
    }
    Position? position = await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: true);

    if (position == null) {
      position = await getCurrentLocation();
    }
    return position;
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> _handlePermission() async {
    GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return true;
  }
}
