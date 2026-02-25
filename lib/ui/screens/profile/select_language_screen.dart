import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/profile/profile_setup_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';

class SelectLanguageScreen extends StatelessWidget {
  SelectLanguageScreen({super.key});

  final ProfileSetupController controller = Get.put(ProfileSetupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textBlack),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.selectLanguage,
                style: TextStyle(
                  fontSize: AppSizes.fontHeading,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.selectLanguageSub,
                style: TextStyle(
                  fontSize: AppSizes.fontBody,
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.languages.length,
                  itemBuilder: (context, index) {
                    final lang = controller.languages[index];
                    return Obx(() {
                      final isSelected =
                          controller.selectedLanguage.value?.name == lang.name;
                      return GestureDetector(
                        onTap: () => controller.selectedLanguage.value = lang,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryBlue.withAlpha(13)
                                : AppColors.backgroundWhite,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusMd,
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryBlue
                                  : AppColors.inputBorder,
                              width: isSelected ? 1.5 : 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                lang.flagAsset,
                                width: 32.w,
                                height: 32.h,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.flag_circle,
                                    size: 32.w,
                                    color: AppColors.primaryBlue,
                                  );
                                },
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Text(
                                  lang.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                              ),
                              _buildTrailingWidget(isSelected),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                ),
              ),
              CustomButton(
                text: AppStrings.btnContinue,
                onPressed: () => Get.toNamed(AppRoutes.setupProfile),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  // trailing widget
  Widget _buildTrailingWidget(bool isSelected) {
    if (isSelected) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          borderRadius: BorderRadius.circular(AppSizes.radiusRound),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check, color: Colors.white, size: 14.sp),
            SizedBox(width: 4.w),
            Text(
              'Selected',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundLightGrey,
          borderRadius: BorderRadius.circular(AppSizes.radiusRound),
        ),
        child: Text(
          'Select',
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }
}
