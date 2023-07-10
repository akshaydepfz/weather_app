import 'package:flutter/material.dart';
import 'package:weather_app/constants/app_assets.dart';
import 'package:weather_app/constants/app_spacing.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: CircleAvatar(
                backgroundImage: AssetImage(AppAssets.avatar),
              ),
            ),
            AppSpacing.vertical10,
            Text(
              'Angelina',
              style: TextStyle(fontSize: 20, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
