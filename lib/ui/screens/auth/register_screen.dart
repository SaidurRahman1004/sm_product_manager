import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController controller = Get.find<AuthController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
          padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.registerHeader,
                style: TextStyle(fontSize: AppSizes.fontHeading,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack),
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.registerSubHeader,
                style: TextStyle(
                    fontSize: AppSizes.fontBody, color: AppColors.textGrey),
              ),
              SizedBox(height: 32.h),

              CustomTextField(
                label: AppStrings.emailAddress,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: AppStrings.fullName,
                controller: nameController,
              ),
              SizedBox(height: 16.h),
              CustomTextField(
                label: AppStrings.password,
                controller: passwordController,
                isPassword: true,
              ),

              SizedBox(height: 8.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                      Icons.check_circle_outline, color: AppColors.successGreen,
                      size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      AppStrings.passwordRule,
                      style: TextStyle(fontSize: AppSizes.fontSmall,
                          color: AppColors.successGreen),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              Obx(() =>
                  CustomButton(
                    text: AppStrings.btnSignUp,
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      controller.register(nameController.text.trim(),
                          emailController.text.trim(), passwordController.text);
                    },
                  )),

              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.alreadyHaveAccountPrompt,
                      style: TextStyle(color: AppColors.textGrey)),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      AppStrings.btnSignIn,
                      style: TextStyle(color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}