import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:texttile/screen/splesh/splesh_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
if(Platform.isIOS){
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAZAvqX7-l1yae1cDuc7sib7XldYDlVVv8",
        appId: "1:562503554762:ios:6668d6a70afb33aadc8633",
        messagingSenderId: "562503554762",
        projectId: "textile-9bbd8",
        storageBucket: "textile-9bbd8.appspot.com"
    ),
  );
}
else {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAgEkR1-p8Ynewzmy8eWTCJex4HCjIa_3Y",
        appId: "1:562503554762:android:3298b9e7b9a183f9dc8633",
        messagingSenderId: "562503554762",
        projectId: "textile-9bbd8",
        storageBucket: "textile-9bbd8.appspot.com"
    ),
  );
}


  runApp(
     GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}
