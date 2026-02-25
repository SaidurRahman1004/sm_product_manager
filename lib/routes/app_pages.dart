import 'package:get/get.dart';
import '../controllers/onboarding/onboarding_controller.dart';
import '../controllers/onboarding/splash_controller.dart';
import 'app_routes.dart';
import '../ui/screens/splash/splash_screen.dart';
import '../ui/screens/splash/onboarding_screen.dart';




class AppPages {
  // initial routs when app start
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      binding: BindingsBuilder(() {
        // when screen open then load SplashController
        Get.lazyPut<SplashController>(() => SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
  ];
}
