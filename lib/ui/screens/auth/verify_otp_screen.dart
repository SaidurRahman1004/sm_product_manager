import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

class VerifyOtpScreen extends StatelessWidget {
  VerifyOtpScreen({super.key});

  final AuthController controller = Get.find<AuthController>();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Determines if it's from Registration or Forgot Password
    final bool isFromRegister = Get.arguments?['isFromRegister'] ?? false;

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
                AppStrings.verifyCode,
                style: TextStyle(fontSize: AppSizes.fontHeading, fontWeight: FontWeight.bold, color: AppColors.textBlack),
              ),
              SizedBox(height: 12.h),
              Text(
                '${AppStrings.verifyCodeEmailPrompt}${controller.resetEmail.value}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: AppSizes.fontBody, color: AppColors.textGrey, height: 1.5),
              ),
              SizedBox(height: 40.h),

              // Pin Code Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  controller: otpController,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12.r),
                    fieldHeight: 60.h,
                    fieldWidth: 60.w,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    activeColor: AppColors.primaryBlue,
                    inactiveColor: AppColors.inputBorder,
                    selectedColor: AppColors.primaryBlue,
                  ),
                  onChanged: (value) {
                    if (value.length == 4) {
                      controller.verifyOtp(value, isFromRegister: isFromRegister);
                    }
                  },
                ),
              ),

              SizedBox(height: 40.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${AppStrings.resendCode} ', style: TextStyle(color: AppColors.textGrey)),
                  Text('00:48', style: TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}