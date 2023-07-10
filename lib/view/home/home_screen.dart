import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_assets.dart';
import 'package:weather_app/constants/app_color.dart';
import 'package:weather_app/constants/app_spacing.dart';
import 'package:weather_app/provider/home/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).permissionCheck();
    Provider.of<HomeProvider>(context, listen: false).getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {}),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.secondary, width: 2),
                      image: const DecorationImage(
                          image: AssetImage(AppAssets.avatar),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                      color: AppColor.secondary,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.place_outlined,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: width * .50,
                        child: Text(
                          provider.adddress,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Today\'s Report',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            '°F',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          CupertinoSwitch(
                            value: !provider.isFahrenheit,
                            onChanged: (v) => provider.onSwitchChange(),
                            activeColor: Colors.blue,
                            trackColor: AppColor.secondary,
                          ),
                          const Text(
                            '°C',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: provider.currentWeather == null
                        ? const CircularProgressIndicator()
                        : Column(
                            children: [
                              SizedBox(
                                height: width / 2,
                                width: width / 2,
                                child: LottieBuilder.asset(
                                  provider.weatherAnimation(
                                      provider.currentWeather!.weather.code),
                                  reverse: true,
                                ),
                              ),
                              Text(
                                provider.currentWeather!.weather.description,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              AppSpacing.vertical10,
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      provider.isFahrenheit
                                          ? provider
                                              .celsiusToFahrenheit(double.parse(
                                                  provider.currentWeather!.temp
                                                      .toString()))
                                              .round()
                                              .toString()
                                          : provider.currentWeather!.temp
                                              .toString(),
                                      style: const TextStyle(
                                          fontSize: 35, color: Colors.white)),
                                  Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.blue, width: 4),
                                        shape: BoxShape.circle),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .13),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherIconCard(
                                      icon: AppAssets.wind,
                                      value: double.parse(provider
                                              .currentWeather!.windSpd
                                              .toString())
                                          .round()
                                          .toString(),
                                      title: 'Wind Speed'),
                                  WeatherIconCard(
                                      icon: AppAssets.humidity,
                                      value:
                                          "${provider.currentWeather!.rh.toString()}%",
                                      title: 'Humidity'),
                                  WeatherIconCard(
                                      icon: AppAssets.clouds,
                                      value: double.parse(provider
                                              .currentWeather!.windSpd
                                              .toString())
                                          .round()
                                          .toString(),
                                      title: 'Cloud Coverage'),
                                ],
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherIconCard extends StatelessWidget {
  const WeatherIconCard({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
  });
  final String icon;
  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: Image.asset(icon),
        ),
        AppSpacing.vertical10,
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        AppSpacing.vertical5,
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}

class BottomBarIcon extends StatelessWidget {
  const BottomBarIcon({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  final String icon;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 30,
        width: 30,
        child: Image.asset(
          icon,
          color: isSelected ? Colors.blue : Colors.grey,
        ),
      ),
    );
  }
}
