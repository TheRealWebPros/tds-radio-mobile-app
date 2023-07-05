import 'package:geolocator/geolocator.dart';

class LocationRepository {
  Future<LocationPermission> requestLocationPermission({
    required void Function(String) onError,
  }) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      onError('Location services are disabled.');
      return LocationPermission.denied;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        onError('Location permissions are denied.');
      }
    } else if (permission == LocationPermission.deniedForever) {
      onError(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return permission;
  }
}
