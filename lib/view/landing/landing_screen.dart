import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/landing/landing_provider.dart';
import 'package:weather_app/view/home/home_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LandingProvider>(context);
    return Scaffold(
      body: provider.pages[provider.selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        margin: const EdgeInsets.all(10),
        height: 70,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF232434),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            provider.bottomNavItem.length,
            (i) => BottomBarIcon(
                onTap: () => provider.onBottomIndexChange(i),
                icon: provider.bottomNavItem[i].icon,
                isSelected: i == provider.selectedIndex),
          ),
        ),
      ),
    );
  }
}
