import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final AuthController controller = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();

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
          padding: EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppStrings.forgotPassword,
                style: TextStyle(
                  fontSize: AppSizes.fontHeading,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                AppStrings.forgotPassSub,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppSizes.fontBody,
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 40.h),

              CustomTextField(
                label: AppStrings.emailAddress,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 32.h),
              Obx(
                () => CustomButton(
                  text: AppStrings.btnContinue,
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.forgotPassword(emailController.text.trim());
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
