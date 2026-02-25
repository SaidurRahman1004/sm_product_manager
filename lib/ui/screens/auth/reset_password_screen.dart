import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final AuthController controller = Get.find<AuthController>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.resetPassword,
                style: TextStyle(
                  fontSize: AppSizes.fontHeading,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                AppStrings.resetPassSub,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.fontBody,
                  color: AppColors.textGrey,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 40.h),

              CustomTextField(
                label: AppStrings.newPassword,
                controller: newPasswordController,
                isPassword: true,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: AppStrings.confirmNewPassword,
                controller: confirmPasswordController,
                isPassword: true,
              ),

              SizedBox(height: 32.h),
              Obx(
                () => CustomButton(
                  text: AppStrings.btnSubmit,
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    if (newPasswordController.text ==
                        confirmPasswordController.text) {
                      controller.resetPassword(newPasswordController.text);
                    } else {
                      Get.snackbar(
                        AppStrings.error,
                        'Passwords do not match',
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
