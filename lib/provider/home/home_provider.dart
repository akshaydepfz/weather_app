import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_app/constants/app_assets.dart';
import 'package:weather_app/model/current_weather_model.dart';

class HomeProvider extends ChangeNotifier {
  CurrentWeatherModel? currentWeather;
  final String _key = '03c1231a65c6405e96472008e9846ae3';
  String _address = 'Fetching address...';
  String get adddress => _address;
  double longitude = 0;
  double latitude = 0;
  final Dio dio = Dio();

  bool _isFahrenheit = false;
  bool get isFahrenheit => _isFahrenheit;

//<-------> SWITCH CHANGE VALUE <------->
  void onSwitchChange() {
    _isFahrenheit = !_isFahrenheit;
    notifyListeners();
  }

//<-------> CELSIUS FARENHEIT CONVERTER <------->
  double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

//<-------> PERMISSION CHECK <------->
  Future<void> permissionCheck() async {
    await Permission.location.request();
    if (await Permission.location.request().isGranted) {
      print('isGranted');
    } else if (await Permission.location.request().isDenied) {
      print('isDenied');
    }
  }

//<-------> WEATHER CODE BY WEATHERBIT<------->
  String weatherAnimation(int code) {
    List<int> rainCode = [
      200,
      201,
      202,
      230,
      231,
      300,
      301,
      302,
      500,
      501,
      502,
      511,
      520,
      521,
      522
    ];

    List<int> sunnyCode = [800, 801];
    List<int> snowCode = [600, 601, 602];
    List<int> cloudCode = [802, 803, 804];

    if (rainCode.contains(code)) {
      return AppAssets.rainingLottie;
    } else if (sunnyCode.contains(code)) {
      return AppAssets.sunnyLottie;
    } else if (snowCode.contains(code)) {
      return AppAssets.snowLottie;
    } else if (cloudCode.contains(code)) {
      return AppAssets.cloudLottie;
    }
    return AppAssets.sunnyLottie;
  }

//<-------> GET CURRENT LOCATION <------->
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      notifyListeners();
      getCurrentWeather();
      getAddressFromLatLong(position.latitude, position.longitude);
    } catch (e) {
      permissionCheck();
    }
  }

//<-------> FETCH ADDRESS FROM LAT LONG <------->
  Future<void> getAddressFromLatLong(lat, long) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
      Placemark place = placeMarks[0];
      _address = "${place.locality}, ${place.subLocality}";
      latitude = lat;
      longitude = long;
      notifyListeners();
      print(_address);
    } catch (e) {}
  }

//<-------> CURRENT WEATHER GET <------->
  Future<void> getCurrentWeather() async {
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
