import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm_product_manager/core/constants/app_strings.dart';
import '../data/data_sources/remote/api_client.dart';
import '../core/constants/api_constants.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  var isLoading = false.obs;
  //save email for passwoard reset
  var resetEmail = ''.obs;
  //cpmon snk
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

  // forget pass otp
  Future<void> forgotPassword(String email) async {
    if (email.isEmpty) {
      _showMessage('Error', "Please enter your email", isError: true);
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
        resetEmail.value = email; // save email for password reset next Screen
        _showMessage('Success', data['message']);
        Get.toNamed(AppRoutes.verifyOtp); // Verify OTP page
      } else {
        _showMessage('Error', data['message'] ?? 'Failed to send OTP', isError: true);
      }
    } catch (e) {
      _showMessage('Error', 'Network error occurred', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  //Verify OTP
  Future<void> verifyOtp(String otp) async {
    if (otp.length < 4) {
      _showMessage('Error', 'Please enter a valid OTP', isError: true);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiConstants.baseUrl + ApiConstants.verifyOtp,
        body: {
          'email': resetEmail.value,
          'otp': int.parse(otp),
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        _showMessage('Success', data['message']);
        Get.toNamed(AppRoutes.resetPassword);
      } else {
        _showMessage('Error', data['message'] ?? 'Invalid OTP', isError: true);
      }
    } catch (e) {
      _showMessage('Error', 'Network error occurred', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  //  Reset Password
  Future<void> resetPassword(String newPassword) async {
    if (newPassword.length < 8) {
      _showMessage('Error', 'Password must be at least 8 characters long', isError: true);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _apiClient.post(
        ApiConstants.baseUrl + ApiConstants.resetPassword,
        body: {
          'email': resetEmail.value,
          'password': newPassword,
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        _showSuccessDialog();
      } else {
        _showMessage('Error', data['message'] ?? 'Failed to reset password', isError: true);
      }
    } catch (e) {
      _showMessage('Error', 'Network error occurred', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // success Dialog
  void _showSuccessDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.blue, size: 64),
              const SizedBox(height: 16),
              const Text(
                'Success',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your password is successfully created',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: const Text('Continue', style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}