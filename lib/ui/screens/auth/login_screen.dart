import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController controller = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSizes.paddingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Image.asset(AppAssets.bulbSignIn, height: 80.h),
              SizedBox(height: 24.h),
              Text(
                AppStrings.welcomeBack,
                style: TextStyle(
                  fontSize: AppSizes.fontHeading,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.loginSubHeader,
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
              SizedBox(height: 16.h),
              CustomTextField(
                label: AppStrings.password,
                controller: passwordController,
                isPassword: true,
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (val) {},
                        activeColor: AppColors.primaryBlue,
                      ),
                      Text(
                        AppStrings.rememberMe,
                        style: TextStyle(fontSize: AppSizes.fontSmall),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: Text(
                      AppStrings.forgotPassword,
                      style: TextStyle(
                        fontSize: AppSizes.fontSmall,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Obx(
                () => CustomButton(
                  text: AppStrings.btnSignIn,
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.login(
                      emailController.text.trim(),
                      passwordController.text,
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.newUserPrompt,
                    style: TextStyle(color: AppColors.textGrey),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.register),
                    child: Text(
                      AppStrings.createAccount,
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
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
