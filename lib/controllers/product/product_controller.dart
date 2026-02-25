import 'dart:io';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

class ProductController extends GetxController {
  final ProductRepository _repository = ProductRepository();

  var productList = <ProductModel>[].obs;
  var isLoading = false.obs;
  //add update dell loader
  var isActionLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // Fetch Products
  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      final products = await _repository.getProducts();
      // update ui list
      productList.assignAll(products);
    } catch (e) {
      Get.snackbar(AppStrings.error, 'Could not load products');
    } finally {
      isLoading.value = false;
    }
  }

  // Add Product
  Future<bool> addProduct(Map<String, dynamic> productData, File imageFile) async {
    isActionLoading.value = true;
    final success = await _repository.createProduct(productData, imageFile);
    if (success) {
      // Refresh list
      await fetchProducts();
    }
    isActionLoading.value = false;
    return success;
  }

  // Edit
  Future<bool> editProduct(String productId, Map<String, dynamic> productData, File? imageFile) async {
    isActionLoading.value = true;
    final success = await _repository.updateProduct(productId, productData, imageFile);
    if (success) {
      // Refresh list
      await fetchProducts();
    }
    isActionLoading.value = false;
    return success;
  }

  // Delete
  Future<void> deleteProduct(String productId) async {
    isActionLoading.value = true;
    final success = await _repository.deleteProduct(productId);

    if (success) {
      productList.removeWhere((p) => p.id == productId);
      Get.back();
      Get.snackbar(
        AppStrings.success,
        'Product deleted successfully',
        backgroundColor: AppColors.successGreen,
        colorText: AppColors.backgroundWhite,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        AppStrings.error,
        'Failed to delete product',
        backgroundColor: AppColors.errorRed,
        colorText: AppColors.backgroundWhite,
      );
    }
    isActionLoading.value = false;
  }
}