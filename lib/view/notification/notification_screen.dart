import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'No Notification Found',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
