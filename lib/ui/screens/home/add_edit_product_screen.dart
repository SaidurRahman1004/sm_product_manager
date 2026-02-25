import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../controllers/product/add_edit_product_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/custom_button.dart';

class AddEditProductScreen extends StatelessWidget {
  AddEditProductScreen({super.key});

  final AddEditProductController controller = Get.find<AddEditProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.isEditing.value
                ? AppStrings.btnEditProduct
                : AppStrings.addNewProduct,
            style: const TextStyle(
              color: AppColors.textBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                left: AppSizes.paddingLg,
                right: AppSizes.paddingLg,
                bottom: 120.h,
                top: 16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: controller.pickImage,
                    child: DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        radius: Radius.circular(16.r),
                        color: AppColors.inputBorder,
                        strokeWidth: 1.5,
                        dashPattern: const [6, 4],
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 32.h),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Obx(() {
                          if (controller.imageFile.value != null) {
                            return Image.file(
                              controller.imageFile.value!,
                              height: 100.h,
                            );
                          }
                          //edit mode img
                          else if (controller
                              .existingImageUrl
                              .value
                              .isNotEmpty) {
                            return CachedNetworkImage(
                              imageUrl: controller.existingImageUrl.value,
                              height: 100.h,
                            );
                          } else {
                            return Column(
                              children: [
                                Icon(
                                  Icons.image_outlined,
                                  size: 40.sp,
                                  color: AppColors.textBlack,
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  AppStrings.uploadPhoto,
                                  style: TextStyle(
                                    fontSize: AppSizes.fontSubtitle,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textBlack,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  AppStrings.uploadPhotoSub,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.textGrey,
                                    height: 1.5,
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.textBlack,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.radiusRound,
                                    ),
                                  ),
                                  child: Text(
                                    AppStrings.chooseFile,
                                    style: TextStyle(
                                      fontSize: AppSizes.fontSmall,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textBlack,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),

                  //Frpms
                  _buildInputField(
                    label: 'Product Name',
                    hint: 'Type product name',
                    controller: controller.nameController,
                  ),

                  // Category Dropdown
                  Obx(
                    () => _buildDropdownField(
                      label: 'Select Category',
                      value: controller.selectedCategory.value,
                      items: [
                        'Electronics',
                        'Gaming',
                        'Peripherals',
                        'Fashion',
                      ],
                      onChanged: (val) =>
                          controller.selectedCategory.value = val!,
                    ),
                  ),

                  _buildInputField(
                    label: 'Description',
                    hint: 'Type Description',
                    controller: controller.descriptionController,
                    maxLines: 4,
                  ),
                  _buildInputField(
                    label: 'Price',
                    hint: 'Type Price',
                    controller: controller.priceController,
                    isNumber: true,
                  ),

                  _buildInputField(
                    label: 'Brand:',
                    hint: 'Select Brand',
                    controller: controller.brandController,
                  ),
                  _buildInputField(
                    label: 'Discount:',
                    hint: 'Type Discount',
                    controller: controller.discountController,
                    isNumber: true,
                  ),
                  _buildInputField(
                    label: 'Stoke',
                    hint: 'Select Stoke',
                    controller: controller.stockController,
                    isNumber: true,
                  ),
                  _buildInputField(
                    label: 'Tags',
                    hint: 'Select Tag (comma separated)',
                    controller: controller.tagsController,
                  ),

                  // Active STatus Dropdown
                  Obx(
                    () => _buildDropdownField(
                      label: 'Active',
                      value: controller.isActive.value,
                      items: ['Active', 'Inactive'],
                      onChanged: (val) => controller.isActive.value = val!,
                    ),
                  ),

                  _buildInputField(
                    label: 'Weight',
                    hint: 'Type weight',
                    controller: controller.weightController,
                    isNumber: true,
                  ),
                  _buildInputField(
                    label: 'Colors',
                    hint: 'Select color (comma separated)',
                    controller: controller.colorsController,
                  ),
                  _buildInputField(
                    label: 'Dimensions',
                    hint: 'Type dimensions',
                    controller: controller.dimensionsController,
                  ),
                ],
              ),
            ),

            //Button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: AppSizes.paddingLg,
                  right: AppSizes.paddingLg,
                  bottom: 32.h,
                  top: 20.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(16),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Obx(
                  () => CustomButton(
                    text: AppStrings.btnSubmit,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.submit,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Input Feild
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
    bool isNumber = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: AppSizes.fontBody,
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 12.h),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.textLightGrey,
                fontSize: AppSizes.fontBody,
              ),
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Dropdown Field
  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: AppSizes.fontBody,
              fontWeight: FontWeight.bold,
              color: AppColors.textBlack,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5), // ফিগমার গ্রে ব্যাকগ্রাউন্ড
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textGrey,
                ),
                style: TextStyle(
                  color: AppColors.textBlack,
                  fontSize: AppSizes.fontBody,
                ),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
