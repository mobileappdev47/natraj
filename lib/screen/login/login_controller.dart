import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texttile/screen/dashboard/dashboard_screen.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;


    QuerySnapshot querySnapshot = await _firestore
        .collection('user')
        .where('email', isEqualTo: email)
        .get();


    if (querySnapshot.docs.isNotEmpty) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        Get.to(const DashBoardScreen());
      } catch (e) {
        print('Error signing in: $e');
      }
    } else {
      print('Invalid credentials');
    }
  }
}
