import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';

class EnableLocationScreen extends StatelessWidget {
  const EnableLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            mainAxisAlignment: .center,
            children: [


              Image.asset(AppAssets.map, height: 80.h, width: 80.w),

              SizedBox(height: 32.h),
              Text(
                AppStrings.enableLocation,
                style: TextStyle(
                  fontSize: AppSizes.fontHeading,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                AppStrings.enableLocationSub,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.fontBody,
                  color: AppColors.textGrey,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 40.h),
              CustomButton(
                text: AppStrings.btnEnable,
                onPressed: () {
                  Get.toNamed(AppRoutes.selectLanguage);
                },
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.setupProfile),
                child: Text(
                  AppStrings.btnSkip,
                  style: TextStyle(
                    fontSize: AppSizes.fontBody,
                    color: AppColors.textBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
