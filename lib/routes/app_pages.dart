import 'package:get/get.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/onboarding/onboarding_controller.dart';
import '../controllers/onboarding/splash_controller.dart';
import '../ui/screens/auth/forgot_password_screen.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/auth/register_screen.dart';
import '../ui/screens/auth/reset_password_screen.dart';
import '../ui/screens/auth/verify_otp_screen.dart';
import '../ui/screens/home/add_edit_product_screen.dart';
import '../ui/screens/profile/enable_location_screen.dart';
import '../ui/screens/profile/profile_screen.dart';
import '../ui/screens/profile/select_language_screen.dart';
import '../ui/screens/profile/setup_profile_screen.dart';
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
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordScreen(),
      binding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    ),
    GetPage(
      name: AppRoutes.verifyOtp,
      page: () => VerifyOtpScreen(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.enableLocation,
      page: () => const EnableLocationScreen(),
    ),
    GetPage(
      name: AppRoutes.selectLanguage,
      page: () => SelectLanguageScreen(),
    ),
    GetPage(
      name: AppRoutes.setupProfile,
      page: () => SetupProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () =>  ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.addEditProduct,
      page: () => AddEditProductScreen(),
    ),
  ];
}
