import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controllers/profile/profile_setup_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class SetupProfileScreen extends StatelessWidget {
  SetupProfileScreen({super.key});

  final ProfileSetupController controller = Get.find<ProfileSetupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: const Text(AppStrings.setupProfile, style: TextStyle(color: AppColors.textBlack, fontWeight: FontWeight.bold)),
        centerTitle: true,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Upload
              Center(
                child: GestureDetector(
                  onTap: controller.pickImage,
                  child: Obx(() => Column(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: controller.profileImage.value != null ? FileImage(controller.profileImage.value!) : null,
                        child: controller.profileImage.value == null ? Icon(Icons.person, size: 50.sp, color: Colors.grey) : null,
                      ),
                      SizedBox(height: 8.h),
                      Text(AppStrings.uploadProfilePic, style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                    ],
                  )),
                ),
              ),
              SizedBox(height: 32.h),

              // About Us
              CustomTextField(
                label: AppStrings.aboutUs,
                controller: controller.aboutUsController,
              ),
              SizedBox(height: 16.h),

              // Date of Birth
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    controller.dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
                  }
                },
                child: AbsorbPointer(
                  child: CustomTextField(
                    label: AppStrings.dateOfBirth,
                    controller: controller.dobController,
                    hintText: 'YYYY-MM-DD',
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Gender Dropdown
              Text(AppStrings.gender, style: TextStyle(fontSize: AppSizes.fontSmall, fontWeight: FontWeight.w500)),
              SizedBox(height: 8.h),
              Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.inputBorder),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: controller.selectedGender.value,
                    items: ['Male', 'Female', 'Other'].map((String value) {
                      return DropdownMenuItem<String>(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) controller.selectedGender.value = newValue;
                    },
                  ),
                ),
              )),

              SizedBox(height: 40.h),
              Obx(() => CustomButton(
                text: AppStrings.btnNext,
                isLoading: controller.isLoading.value,
                onPressed: controller.completeProfile,
              )),
            ],
          ),
        ),
      ),
    );
  }
}