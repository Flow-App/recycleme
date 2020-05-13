import 'package:geolocator/geolocator.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class GeoRepo {
  static Map<String, double> userLocation;

  Future<double> getDistanceUserAndCp(double lat, double long) async {
    if (userLocation == null) {
      await getUserCurrentLocation();
    }
    final userLat = userLocation['lat'];
    final userLong = userLocation['long'];
    return SphericalUtil.computeDistanceBetween(
        LatLng(userLat, userLong), LatLng(lat, long));
  }

  Future<void> getUserCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (position.latitude != null && position.longitude != null) {
        userLocation = {'lat': position.latitude, 'long': position.longitude};
      } else {
        Position position = await Geolocator()
            .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
        userLocation = {'lat': position.latitude, 'long': position.longitude};
      }
    } catch (e) {
      print('error getUserCurrentLocation = $e ');
      userLocation = null;
    }
  }
}
