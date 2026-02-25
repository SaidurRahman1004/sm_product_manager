import 'package:get/get.dart';

import '../../data/data_sources/local/shared_prefs_helper.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  //navigate to next screen
  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final token = SharedPrefsHelper.getToken();
    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  }
}
