import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:texttile/screen/dashboard/dashboard_screen.dart';
import 'package:texttile/screen/login/login_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToNextScreen();

  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {

      Get.offAll(() => DashBoardScreen());
    } else {

      Get.offAll(() => LoginScreen());
    }
  }
}
