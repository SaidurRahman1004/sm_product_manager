import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/models/product_model.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    //pass arguments from product screen
    final ProductModel product = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: const Text(
          AppStrings.serviceDetail,
          style: TextStyle(
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textBlack),
          onPressed: () => Get.back(),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.w),
            decoration: const BoxDecoration(
              color: AppColors.errorRed,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: 20.sp,
              ),
              onPressed: () => _showDeleteDialog(product.id!),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                left: AppSizes.paddingLg,
                right: AppSizes.paddingLg,
                bottom: 120.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  // Image with Stack for Category Tag
                  Stack(
                    children: [
                      Container(
                        height: 220.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLightGrey,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child:
                              product.image != null && product.image!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: product.image!,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                      Positioned(
                        top: 12.h,
                        left: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radiusRound,
                            ),
                          ),
                          child: Text(
                            product.category?.toUpperCase() ?? 'N/A',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  // Title and Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            FittedBox(
                              child: Text(
                                product.name ?? '',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textBlack,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            if (product.isActive == true)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.tagPurple.withAlpha(26),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  'active',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: AppColors.tagPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${product.price?.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Stock and Discount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: AppColors.successGreen,
                            size: 16.sp,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            AppStrings.inStock,
                            style: TextStyle(
                              color: AppColors.successGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      if (product.isDiscounted == true)
                        Text(
                          'Discount: \$${(product.price! * (product.discountPercent! / 100)).toStringAsFixed(0)}',
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: AppSizes.fontSmall,
                          ),
                        ),
                    ],
                  ),

                  // Divider Dotted
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: DottedBorder(
                      options: CustomPathDottedBorderOptions(
                        color: AppColors.inputBorder,
                        strokeWidth: 1.5,
                        dashPattern: const [6, 4],
                        customPath: (size) => Path()..lineTo(size.width, 0),
                        padding: EdgeInsets.zero,
                      ),
                      child: const SizedBox(width: double.infinity, height: 1),
                    ),
                  ),

                  // Corsair Gaming Headphones (Sub-brand)
                  Text(
                    product.brand ?? '',
                    style: TextStyle(
                      fontSize: AppSizes.fontSubtitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Tags
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    children: [
                      _buildChip(
                        '${product.category} Categorise',
                        AppColors.tagPurple,
                      ),
                      if (product.tags != null && product.tags!.isNotEmpty)
                        _buildChip(
                          product.tags!.first.capitalizeFirst!,
                          AppColors.tagPurple,
                        ),
                      _buildChip('${product.brand} Brand', AppColors.tagPurple),
                      if (product.weight != null)
                        _buildChip(
                          'Weight: ${product.weight}',
                          AppColors.tagPurple,
                        ),
                      if (product.dimensions != null)
                        _buildChip(
                          'Dimensions: ${product.dimensions}',
                          AppColors.tagPurple,
                        ),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // Description
                  Text(
                    AppStrings.description,
                    style: TextStyle(
                      fontSize: AppSizes.fontSubtitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textBlack,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    product.description ?? '',
                    style: TextStyle(
                      fontSize: AppSizes.fontBody,
                      color: AppColors.textGrey,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Fixed Button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: AppSizes.paddingLg,
                  right: AppSizes.paddingLg,
                  bottom: 32.h,
                  top: 40.h,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withAlpha(0),
                      Colors.white,
                      Colors.white,
                    ],
                    stops: const [0.0, 0.4, 1.0],
                  ),
                ),
                child: CustomButton(
                  text: AppStrings.btnEditProduct,
                  onPressed: () =>
                      Get.toNamed(AppRoutes.addEditProduct, arguments: product),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Figma Style Chip
  Widget _buildChip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
        ),
      ),
    );
  }

  void _showDeleteDialog(String id) {
    Get.defaultDialog(
      title: 'Delete Product',
      middleText: 'Are you sure you want to delete this product?',
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      buttonColor: Colors.redAccent,
      onConfirm: () {
        Get.back();
        controller.deleteProduct(id);
      },
    );
  }
}
