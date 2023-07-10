import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/model/current_weather_model.dart';

class SearchProvider extends ChangeNotifier {
  String _address = '';
  String get address => _address;
  double longitude = 0;
  double latitude = 0;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Dio dio = Dio();
  CurrentWeatherModel? currentWeather;
  final String _key = '03c1231a65c6405e96472008e9846ae3';

  final TextEditingController controller = TextEditingController();

//<-------> GET CURRENT LOCATION FROM SEARCHED QUARY<------->
  Future<Position> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Handle the scenario when user denies the permission
      }
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

  //<-------> SEARCH LOCATION <------->
  void searchLocation(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      List<Location> locations = await locationFromAddress(controller.text);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        latitude = location.latitude;
        longitude = location.longitude;
        _isLoading = false;
        notifyListeners();
        getAddressFromLatLong(location.latitude, location.longitude);
        getWeather();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Location not found',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
      _isLoading = false;
      notifyListeners();
    }
  }

//<-------> GET ADDRESS FROM LAT LONG <------->
  Future<void> getAddressFromLatLong(lat, long) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
      Placemark place = placeMarks[0];
      _address = "${place.locality}, ${place.subLocality} ${place.country}";
      latitude = lat;
      longitude = long;
      notifyListeners();
    } catch (e) {}
  }
//<-------> GET WEATHER <------->
  Future<void> getWeather() async {
    Map<String, dynamic> queryParams = {
      'lat': latitude,
      'lon': longitude,
      'key': _key,
    };

    try {
      final response = await dio.get(
        'https://api.weatherbit.io/v2.0/current',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'][0];
        currentWeather = CurrentWeatherModel.fromJson(data);
        notifyListeners();
      }
    } on DioException catch (e) {
      print(e.response!.data);
    }
  }
}
