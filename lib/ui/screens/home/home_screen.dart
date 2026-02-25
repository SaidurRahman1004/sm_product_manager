import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../controllers/product/product_controller.dart';
import '../../../controllers/profile/profile_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductController productController = Get.put(ProductController());
  final ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            //  Blue HeaderSection
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 120.h,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.paddingLg,
                  vertical: 16.h,
                ),
                child: _buildHeader(),
              ),
            ),

            // BottomWhite Curved Section
            Positioned(
              top: 90.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundLightGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: RefreshIndicator(
                  onRefresh: () => productController.fetchProducts(),
                  color: AppColors.primaryBlue,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.only(
                          left: AppSizes.paddingLg,
                          right: AppSizes.paddingLg,
                          top: 32.h,
                          bottom: 100.h,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            _buildTabs(),
                            SizedBox(height: 24.h),
                            _buildProductGrid(),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //  Button
            Positioned(
              bottom: 30.h,
              left: AppSizes.paddingLg,
              right: AppSizes.paddingLg,
              child: CustomButton(
                text: AppStrings.btnCreateProduct,
                onPressed: () => Get.toNamed(AppRoutes.addEditProduct),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header
  Widget _buildHeader() {
    return Obx(() {
      final user = profileController.user.value;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.profile),
                child: CircleAvatar(
                  radius: 24.r,
                  backgroundColor: Colors.white,
                  backgroundImage: user?.profileImage != null
                      ? CachedNetworkImageProvider(user!.profileImage!)
                      : null,
                  child: user?.profileImage == null
                      ? const Icon(Icons.person, color: Colors.grey)
                      : null,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hi, ${user?.fullName ?? 'User'}!',
                    style: TextStyle(
                      fontSize: AppSizes.fontSubtitle,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 14.sp, color: Colors.white),
                      SizedBox(width: 4.w),
                      Text(
                        user?.country ?? 'Location not set',
                        style: TextStyle(
                          fontSize: AppSizes.fontSmall,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }

  // Tabs
  Widget _buildTabs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.myServices,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textBlack,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.circular(AppSizes.radiusRound),
              ),
              child: const Text(
                AppStrings.tabOngoing,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSizes.radiusRound),
                border: Border.all(color: AppColors.inputBorder),
              ),
              child: Text(
                AppStrings.tabUpcoming,
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Product Grid
  Widget _buildProductGrid() {
    return Obx(() {
      if (productController.isLoading.value &&
          productController.productList.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.primaryBlue),
        );
      }

      if (productController.productList.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 40.h),
            child: Text(
              'No products found.',
              style: TextStyle(color: AppColors.textGrey),
            ),
          ),
        );
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
          childAspectRatio: 0.65,
        ),
        itemCount: productController.productList.length,
        itemBuilder: (context, index) {
          final product = productController.productList[index];
          return ProductCard(
            product: product,
            onViewDetails: () =>
                Get.toNamed(AppRoutes.productDetails, arguments: product),
            onEdit: () =>
                Get.toNamed(AppRoutes.addEditProduct, arguments: product),
          );
        },
      );
    });
  }
}
