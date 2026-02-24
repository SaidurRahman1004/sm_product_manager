import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../controllers/onboarding/splash_controller.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

import '../../../core/constants/app_strings.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Image
              Image.asset(
                AppAssets.onboardingCar,
                height: 120.h,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 32.h),
              //Heading
              Text(
                AppStrings.splashHeading1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.fontHeading,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 16.h),
              // Sub title
              Text(
                AppStrings.splashSub1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.fontBody,
                  color: AppColors.textGrey,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              //loading indicators
              SpinKitFadingCircle(color: AppColors.primaryBlue, size: 40.sp),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
