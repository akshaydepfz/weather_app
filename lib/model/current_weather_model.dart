class CurrentWeatherModel {
  double appTemp;
  int aqi;
  String cityName;
  int clouds;
  String countryCode;
  String datetime;
  double dewpt;
  double dhi;
  double dni;
  double elevAngle;
  double ghi;
  dynamic gust;
  double hAngle;
  double lat;
  double lon;
  String obTime;
  String pod;
  double precip;
  double pres;
  int rh;
  double slp;
  int snow;
  double solarRad;
  List<String> sources;
  String stateCode;
  String station;
  String sunrise;
  String sunset;
  double temp;
  String timezone;
  int ts;
  double uv;
  int vis;
  Weather weather;
  String windCdir;
  String windCdirFull;
  int windDir;
  double windSpd;

  CurrentWeatherModel({
    required this.appTemp,
    required this.aqi,
    required this.cityName,
    required this.clouds,
    required this.countryCode,
    required this.datetime,
    required this.dewpt,
    required this.dhi,
    required this.dni,
    required this.elevAngle,
    required this.ghi,
    this.gust,
    required this.hAngle,
    required this.lat,
    required this.lon,
    required this.obTime,
    required this.pod,
    required this.precip,
    required this.pres,
    required this.rh,
    required this.slp,
    required this.snow,
    required this.solarRad,
    required this.sources,
    required this.stateCode,
    required this.station,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.timezone,
    required this.ts,
    required this.uv,
    required this.vis,
    required this.weather,
    required this.windCdir,
    required this.windCdirFull,
    required this.windDir,
    required this.windSpd,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherModel(
        appTemp: json["app_temp"]?.toDouble(),
        aqi: json["aqi"],
        cityName: json["city_name"],
        clouds: json["clouds"],
        countryCode: json["country_code"],
        datetime: json["datetime"],
        dewpt: json["dewpt"]?.toDouble(),
        dhi: json["dhi"]?.toDouble(),
        dni: json["dni"]?.toDouble(),
        elevAngle: json["elev_angle"]?.toDouble(),
        ghi: json["ghi"]?.toDouble(),
        gust: json["gust"],
        hAngle: json["h_angle"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        obTime: json["ob_time"],
        pod: json["pod"],
        precip: json["precip"],
        pres: json["pres"]?.toDouble(),
        rh: json["rh"],
        slp: json["slp"]?.toDouble(),
        snow: json["snow"],
        solarRad: json["solar_rad"]?.toDouble(),
        sources: List<String>.from(json["sources"].map((x) => x)),
        stateCode: json["state_code"],
        station: json["station"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"]?.toDouble(),
        timezone: json["timezone"],
        ts: json["ts"],
        uv: json["uv"]?.toDouble(),
        vis: json["vis"],
        weather: Weather.fromJson(json["weather"]),
        windCdir: json["wind_cdir"],
        windCdirFull: json["wind_cdir_full"],
        windDir: json["wind_dir"],
        windSpd: json["wind_spd"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "app_temp": appTemp,
        "aqi": aqi,
        "city_name": cityName,
        "clouds": clouds,
        "country_code": countryCode,
        "datetime": datetime,
        "dewpt": dewpt,
        "dhi": dhi,
        "dni": dni,
        "elev_angle": elevAngle,
        "ghi": ghi,
        "gust": gust,
        "h_angle": hAngle,
        "lat": lat,
        "lon": lon,
        "ob_time": obTime,
        "pod": pod,
        "precip": precip,
        "pres": pres,
        "rh": rh,
        "slp": slp,
        "snow": snow,
        "solar_rad": solarRad,
        "sources": List<dynamic>.from(sources.map((x) => x)),
        "state_code": stateCode,
        "station": station,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp,
        "timezone": timezone,
        "ts": ts,
        "uv": uv,
        "vis": vis,
        "weather": weather.toJson(),
        "wind_cdir": windCdir,
        "wind_cdir_full": windCdirFull,
        "wind_dir": windDir,
        "wind_spd": windSpd,
      };
}

class Weather {
  int code;
  String icon;
  String description;

  Weather({
    required this.code,
    required this.icon,
    required this.description,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        code: json["code"],
        icon: json["icon"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "icon": icon,
        "description": description,
      };
}
