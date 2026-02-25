import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_assets.dart';
import '../../widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  children: [
                    // Onboarding 1
                    _buildOnboardingContent(
                      image: AppAssets.onboardingStop,
                      title: AppStrings.splashHeading2,
                      subtitle: AppStrings.splashSub2,
                    ),
                    // Onboarding  2
                    _buildOnboardingContent(
                      image: AppAssets.onboardingSkill,
                      title: AppStrings.splashHeading3,
                      subtitle: AppStrings.splashSub3,
                    ),
                  ],
                ),
              ),

              // SmoothPage Indicator
              SmoothPageIndicator(
                controller: controller.pageController,
                count: 2,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.primaryBlue,
                  dotColor: AppColors.indicatorInactive,
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  expansionFactor: 3,
                ),
              ),
              SizedBox(height: 32.h),

              // Reactive button using GetX Obx
              Obx(
                () => CustomButton(
                  text: controller.currentPage.value == 0
                      ? AppStrings.btnNext
                      : AppStrings.btnGetStarted,
                  onPressed: controller.goToNextPage,
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  // বOnboarding Content re Useable
  Widget _buildOnboardingContent({
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 250.h, fit: BoxFit.contain),
        SizedBox(height: 40.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSizes.fontHeading,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: AppSizes.fontBody,
            color: AppColors.textGrey,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
