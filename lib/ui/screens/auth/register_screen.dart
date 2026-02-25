import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_sizes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController controller = Get.find<AuthController>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      controller.checkPasswordStrength(passwordController.text);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                style: TextStyle(
                  fontSize: AppSizes.fontHeading,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.registerSubHeader,
                style: TextStyle(
                  fontSize: AppSizes.fontBody,
                  color: AppColors.textGrey,
                ),
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
              //Password Strength Indicator
              SizedBox(height: 12.h),
              Obx(
                () => Row(
                  children: [
                    // 4 baR Indicator
                    ...List.generate(4, (index) {
                      return Expanded(
                        child: Container(
                          height: 4.h,
                          margin: EdgeInsets.only(right: 6.w),
                          decoration: BoxDecoration(
                            color: index < controller.passwordStrength.value
                                ? AppColors.primaryBlue
                                : const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      );
                    }),
                    // Strength Text
                    SizedBox(width: 8.w),
                    Text(
                      controller.strengthText.value,
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12.h),

              // Validation Rule Text
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      controller.hasMinLength.value
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: controller.hasMinLength.value
                          ? AppColors.successGreen
                          : AppColors.successGreen,
                      size: 16.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        AppStrings.passwordRule,
                        style: TextStyle(
                          fontSize: AppSizes.fontSmall,
                          color: AppColors.successGreen,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),
              //button
              Obx(
                () => CustomButton(
                  text: AppStrings.btnSignUp,
                  isLoading: controller.isLoading.value,
                  onPressed: () {
                    controller.register(
                      nameController.text.trim(),
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
                    AppStrings.alreadyHaveAccountPrompt,
                    style: TextStyle(color: AppColors.textGrey),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      AppStrings.btnSignIn,
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
