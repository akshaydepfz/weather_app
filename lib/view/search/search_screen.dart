import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/app_assets.dart';
import 'package:weather_app/constants/app_color.dart';
import 'package:weather_app/constants/app_spacing.dart';
import 'package:weather_app/provider/home/home_provider.dart';
import 'package:weather_app/provider/search/search_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchProvider>(context);
    final width = MediaQuery.of(context).size.width;
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF232434),
                      ),
                      child: TextField(
                        controller: provider.controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            hintText: 'Search Location',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  AppSpacing.horizontal10,
                  GestureDetector(
                    onTap: () => provider.searchLocation(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF232434),
                      ),
                      child: Image.asset(
                        AppAssets.search,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: provider.currentWeather != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              provider.address,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            AppSpacing.vertical10,
                            const Text(
                              'Now',
                              style: TextStyle(
                                  color: AppColor.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            AppSpacing.vertical10,
                            Text(
                              provider.currentWeather!.weather.description,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                            ),
                            AppSpacing.vertical10,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    homeProvider.isFahrenheit
                                        ? homeProvider
                                            .celsiusToFahrenheit(double.parse(
                                                provider.currentWeather!.temp
                                                    .toString()))
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
                          ],
                        )
                      : provider.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Search any Locations',
                              style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
