import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
//user current page
  var currentPage = 0.obs;
//track page change
  void onPageChanged(int index) {
    currentPage.value = index;
  }
//go to next page
  void goToNextPage() {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Get.offAllNamed('/login');
      print("Go to Login Screen"); //tmp
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
