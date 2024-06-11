import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:texttile/screen/splesh/splesh_controller.dart'; // Replace with your main screen

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }
}
