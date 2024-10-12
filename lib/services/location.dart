import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  static LatLng? userLocation;
  Future<LocationPermission> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  Future<LatLng?> currentLocation() async {
    LocationPermission permission = await requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best),
      );
      return userLocation = LatLng(position.latitude, position.longitude);
    } else {
      return null;
    }
  }

  calcDistanceUnit(LatLng userLocation, LatLng placeLocation) {
    const distance = Distance();
    var meter = distance.as(LengthUnit.Meter, userLocation, placeLocation);

    if (meter < 100) {
      return '$meter M';
    } else {
      meter = meter / 1000;
      var formatted = meter.toStringAsFixed(2);
      return '$formatted KM';
    }
  }

  calcDistance(LatLng userLocation, LatLng placeLocation) {
    const distance = Distance();
    var meter = distance.as(LengthUnit.Meter, userLocation, placeLocation);

    return meter;
  }
}
