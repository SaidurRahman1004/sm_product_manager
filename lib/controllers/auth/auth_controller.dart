import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_strings.dart';
import '../../data/data_sources/local/shared_prefs_helper.dart';
import '../../data/data_sources/remote/api_client.dart';
import '../../routes/app_routes.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  var isLoading = false.obs;

  // Stores email for otp verification
  var resetEmail = ''.obs;

  // Password strength VAriables
  var passwordStrength = 0.0.obs;
  var strengthText = ''.obs;
  var hasMinLength = false.obs;

  // password strength Cng Logic
  void checkPasswordStrength(String pass) {
    double strength = 0;
    if (pass.isEmpty) {
      strength = 0;
      strengthText.value = '';
      hasMinLength.value = false;
    } else {
      if (pass.length >= 8) strength += 1;
      if (pass.contains(RegExp(r'[a-zA-Z]'))) strength += 1;
      if (pass.contains(RegExp(r'[0-9]'))) strength += 1;
      if (pass.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 1;

      if (pass.length >= 8 &&
          pass.contains(RegExp(r'[a-zA-Z]')) &&
          pass.contains(RegExp(r'[0-9]'))) {
        hasMinLength.value = true;
      } else {
        hasMinLength.value = false;
      }

      if (strength == 1)
        strengthText.value = 'Weak';
      else if (strength == 2)
        strengthText.value = 'Fair';
      else if (strength == 3)
        strengthText.value = 'Good';
      else if (strength >= 4)
        strengthText.value = 'Strong';
    }
    passwordStrength.value = strength;
  }

  // Common snk
  void _showMessage(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  // Login
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      _showMessage(
        AppStrings.error,
        'Please enter both email and password',
        isError: true,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiConstants.baseUrl + ApiConstants.login,
        body: {'email': email, 'password': password},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        final String token = data['data']['token'];
        await SharedPrefsHelper.saveToken(token);
        _showMessage(AppStrings.success, 'Logged in successfully!');
        Get.offAllNamed(AppRoutes.enableLocation);
      } else {
        _showMessage(
          AppStrings.error,
          data['message'] ?? 'Login failed',
          isError: true,
        );
      }
    } catch (e) {
      _showMessage(AppStrings.error, AppStrings.netError, isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // Register
  Future<void> register(String fullName, String email, String password) async {
    if (fullName.isEmpty || email.isEmpty || password.length < 8) {
      _showMessage(
        AppStrings.error,
        'Please fill all fields correctly (Password min 8 chars)',
        isError: true,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiConstants.baseUrl + ApiConstants.register,
        body: {'fullName': fullName, 'email': email, 'password': password},
      );

      final data = jsonDecode(response.body);

      if ((response.statusCode == 201 || response.statusCode == 200) &&
          data['success'] == true) {
        resetEmail.value = email;

        // Navigate to OTP screen for Figma flow (Mocking OTP for Registration)
        Get.toNamed(AppRoutes.verifyOtp, arguments: {'isFromRegister': true});
      } else {
        _showMessage(
          AppStrings.error,
          data['message'] ?? 'Registration failed',
          isError: true,
        );
      }
    } catch (e) {
      _showMessage(AppStrings.error, AppStrings.netError, isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // Forgot Password
  Future<void> forgotPassword(String email) async {
    if (email.isEmpty) {
      _showMessage(AppStrings.error, AppStrings.emailError, isError: true);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiConstants.baseUrl + ApiConstants.forgotPassword,
        body: {'email': email},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        resetEmail.value = email;
        Get.toNamed(AppRoutes.verifyOtp, arguments: {'isFromRegister': false});
      } else {
        _showMessage(
          AppStrings.error,
          data['message'] ?? 'Failed to send OTP',
          isError: true,
        );
      }
    } catch (e) {
      _showMessage(AppStrings.error, AppStrings.netError, isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // Verify OTP
  Future<void> verifyOtp(String otp, {bool isFromRegister = false}) async {
    if (otp.length < 4) {
      _showMessage(
        AppStrings.error,
        'Please enter a valid 4-digit OTP',
        isError: true,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiConstants.baseUrl + ApiConstants.verifyOtp,
        body: {'email': resetEmail.value, 'otp': int.parse(otp)},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        if (isFromRegister) {
          _showDynamicSuccessDialog(
            title: AppStrings.registerSuccessHeading,
            subtitle: AppStrings.registerSuccessSub,
            iconPath: AppAssets.successSignIn,
          );
        } else {
          Get.toNamed(AppRoutes.resetPassword);
        }
      } else {
        _showMessage(
          AppStrings.error,
          data['message'] ?? 'Invalid OTP',
          isError: true,
        );
      }
    } catch (e) {
      _showMessage(AppStrings.error, AppStrings.netError, isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // Reset Password
  Future<void> resetPassword(String newPassword) async {
    if (newPassword.length < 8) {
      _showMessage(
        AppStrings.error,
        'Password must be at least 8 characters long',
        isError: true,
      );
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiConstants.baseUrl + ApiConstants.resetPassword,
        body: {'email': resetEmail.value, 'password': newPassword},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        _showDynamicSuccessDialog(
          title: AppStrings.successPopupHeading,
          subtitle: AppStrings.successPopupSub,
          iconPath: AppAssets.listForgetPassCreated,
        );
      } else {
        _showMessage(
          AppStrings.error,
          data['message'] ?? 'Failed to reset password',
          isError: true,
        );
      }
    } catch (e) {
      _showMessage(AppStrings.error, AppStrings.netError, isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // Success dialog reuseable
  void _showDynamicSuccessDialog({
    required String title,
    required String subtitle,
    required String iconPath,
  }) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(iconPath, height: 100),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.login);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF1E65FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
