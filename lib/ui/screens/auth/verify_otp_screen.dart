import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final AuthController controller = Get.find<AuthController>();
  final TextEditingController otpController = TextEditingController();
  late bool isFromRegister;

  late Timer _timer;
  int _start = 48;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    //cheak if come from register page
    isFromRegister = Get.arguments?['isFromRegister'] ?? false;
    startTimer();
  }

  //timer
  void startTimer() {
    setState(() {
      _canResend = false;
      _start = 48;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          _canResend = true;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void resendOtp() {
    if (!isFromRegister) {
      controller.forgotPassword(controller.resetEmail.value);
      startTimer();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 60.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: AppColors.textBlack,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundWhite,
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primaryBlue),
      ),
    );

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
                style: TextStyle(
                  fontSize: AppSizes.fontHeading,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textBlack,
                ),
              ),
              SizedBox(height: 12.h),
              Obx(
                () => Text(
                  '${AppStrings.verifyCodeEmailPrompt}${controller.resetEmail.value}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: AppSizes.fontBody,
                    color: AppColors.textGrey,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Pinput(
                  controller: otpController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  autofocus: true,
                  onCompleted: (pin) {
                    controller.verifyOtp(pin, isFromRegister: isFromRegister);
                  },
                ),
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${AppStrings.resendCode} ',
                    style: TextStyle(color: AppColors.textGrey),
                  ),
                  _canResend
                      ? GestureDetector(
                          onTap: resendOtp,
                          child: Text(
                            'Resend',
                            style: TextStyle(
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Text(
                          '00:${_start.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.bold,
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
