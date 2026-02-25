import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../controllers/profile/profile_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../data/data_sources/local/shared_prefs_helper.dart';
import '../../../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      appBar: AppBar(
        title: const Text(
          AppStrings.profile,
          style: TextStyle(
            color: AppColors.textBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
          child: Obx(() {
            // Check loading state
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue),
              );
            }

            final user = controller.user.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                //Image
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: user?.profileImage != null
                          ? CachedNetworkImageProvider(user!.profileImage!)
                          : null,
                      child: user?.profileImage == null
                          ? Icon(Icons.person, size: 50.sp, color: Colors.grey)
                          : null,
                    ),
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 16.sp),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // User Name
                Text(
                  user?.fullName ?? AppStrings.unknownUser,
                  style: TextStyle(
                    fontSize: AppSizes.fontHeading,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textBlack,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  user?.email ?? '',
                  style: TextStyle(
                    fontSize: AppSizes.fontSmall,
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: 40.h),

                // menu Items
                _buildMenuItem(
                  icon: Icons.edit_outlined,
                  title: AppStrings.editProfile,
                  onTap: () => Get.toNamed(AppRoutes.setupProfile),
                ),
                _buildMenuItem(
                  icon: Icons.help_outline,
                  title: AppStrings.support,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  title: AppStrings.privacy,
                  onTap: () {},
                ),

                const Spacer(),

                //Logout Button
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.logout, color: Colors.orange),
                  title: const Text(
                    AppStrings.logout,
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => _showLogoutDialog(),
                ),
                SizedBox(height: 20.h),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4.h),
      leading: Icon(icon, color: AppColors.textBlack),
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppSizes.fontBody,
          color: AppColors.textBlack,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
      const Icon(Icons.arrow_forward_ios, color: AppColors.textGrey, size: 16),
      onTap: onTap,
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text(AppStrings.logout),
        content: const Text(AppStrings.logoutSub),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              AppStrings.cancel,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () async {
              await SharedPrefsHelper.removeToken();
              Get.offAllNamed(AppRoutes.login);
            },
            child: const Text(
              AppStrings.logout,
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}