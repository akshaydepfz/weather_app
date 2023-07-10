import 'package:flutter/cupertino.dart';
import 'package:weather_app/constants/app_assets.dart';
import 'package:weather_app/model/bottom_nav_model.dart';
import 'package:weather_app/view/home/home_screen.dart';
import 'package:weather_app/view/notification/notification_screen.dart';
import 'package:weather_app/view/profile/profile_screen.dart';
import 'package:weather_app/view/search/search_screen.dart';

class LandingProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void onBottomIndexChange(int i) {
    _selectedIndex = i;
    notifyListeners();
  }

  List<BottomNavigationModel> bottomNavItem = [
    BottomNavigationModel(icon: AppAssets.home),
    BottomNavigationModel(icon: AppAssets.search),
    BottomNavigationModel(icon: AppAssets.bell),
    BottomNavigationModel(icon: AppAssets.user)
  ];
  List<Widget> pages = [
    const HomeScreen(),
    const SearchScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];
}
