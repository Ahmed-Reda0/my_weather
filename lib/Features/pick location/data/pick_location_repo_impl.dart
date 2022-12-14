
import 'package:dartz/dartz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:myweather/Features/home/domain/models/weather_model/location.dart';
import 'package:myweather/Features/pick%20location/domain/repositries/pick_location_repo.dart';
import 'package:myweather/core/Error/exceptions.dart';
import 'package:myweather/core/Error/failures.dart';
import 'package:permission_handler/permission_handler.dart';

class PickLocationRepoImpl implements PickLocationRepo {
  @override
  Future<Either<Failure, String>> getLocation() async {
    Permission.location;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled) {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        return left(
          ServerFailure('Permission denied'),
        );
      } else if (permission == LocationPermission.deniedForever) {
        return left(
          ServerFailure('Permission denied for ever '),
        );
      } else {
        Position position = await Geolocator.getCurrentPosition();

        var cityName = await decodeLocation(position: position);
        return right(cityName);
      }
    } else {
      return left(
        ServerFailure('something went wrong! try again'),
      );
    }
  }

  @override
  Future<String> decodeLocation({required Position position}) async {
    try {
      List<Placemark> placeList =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      return placeList[0].country ?? 'Alexandria';
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
