import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../data/data_sources/remote/api_client.dart';
import '../../routes/app_routes.dart';

// Model for language data
class Language {
  final String name;
  final String flagAsset;

  Language({required this.name, required this.flagAsset});
}

class ProfileSetupController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  var isLoading = false.obs;

  // List of available languages
  final List<Language> languages = [
    Language(name: 'English (US)', flagAsset: AppAssets.usa),
    Language(name: 'Indonesia', flagAsset: AppAssets.indonesia),
    Language(name: 'Afghanistan', flagAsset: AppAssets.afghanistan),
    Language(name: 'Algeria', flagAsset: AppAssets.algeria),
    Language(name: 'Malaysia', flagAsset: AppAssets.malaysia),
    Language(name: 'Arabic', flagAsset: AppAssets.uae),
  ];

  // selection Language
  var selectedLanguage = Rx<Language?>(null);

  @override
  void onInit() {
    super.onInit();
    //default language
    if (languages.isNotEmpty) {
      selectedLanguage.value = languages.first;
    }
  }

  // Profile Form Data
  final TextEditingController aboutUsController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  var selectedGender = 'Male'.obs;
  var profileImage = Rxn<File>();

  // Image Picker Logic
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path);
    }
  }

  // completeProfile api call
  Future<void> completeProfile() async {
    if (dobController.text.isEmpty || aboutUsController.text.isEmpty) {
      Get.snackbar(
        AppStrings.error,
        'Please fill all the fields',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    try {
      final Map<String, dynamic> profileData = {
        // Use the name from the selected Language object
        "country": selectedLanguage.value?.name ?? 'Not Selected',
        "aboutUs": aboutUsController.text,
        "dateOfBirth": dobController.text,
        "gender": selectedGender.value.toLowerCase(),
      };

      final response = await _apiClient.multipartRequest(
        ApiConstants.baseUrl + ApiConstants.completeProfile,
        method: 'PUT',
        fields: {'data': jsonEncode(profileData)},
        imageFile: profileImage.value,
        fileKey: 'image',
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        _showSuccessDialog();
      } else {
        Get.snackbar(
          AppStrings.error,
          data['message'] ?? 'Profile setup failed',
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        AppStrings.error,
        AppStrings.netErrorImg,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Success Dialog
  void _showSuccessDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppAssets.congratulations, height: 80.h, width: 80.w),
              const SizedBox(height: 24),
              Text(
                AppStrings.profileSetupSuccess,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.profileSetupSuccessSub,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              CircularProgressIndicator(color: AppColors.primaryBlue),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
    //Navigate Home 2 sec
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.home);
    });
  }
}
