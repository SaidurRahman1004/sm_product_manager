import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/product_model.dart';
import 'product_controller.dart';

class AddEditProductController extends GetxController {
  final ProductController _productController = Get.find<ProductController>();

  ProductModel? editingProduct;
  var isEditing = false.obs;
  var isLoading = false.obs;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final brandController = TextEditingController();
  final discountController = TextEditingController();
  final stockController = TextEditingController();
  final tagsController = TextEditingController();
  final weightController = TextEditingController();
  final colorsController = TextEditingController();
  final dimensionsController = TextEditingController();

  // DRopdown Variables
  var selectedCategory = 'Electronics'.obs;
  var isActive = 'Active'.obs;

  // ImageVariables
  var imageFile = Rxn<File>();
  var existingImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Edit Mode if data come from routing
    if (Get.arguments != null && Get.arguments is ProductModel) {
      editingProduct = Get.arguments;
      isEditing.value = true;
      _populateFields();
    }
  }

  void _populateFields() {
    nameController.text = editingProduct?.name ?? '';
    selectedCategory.value = editingProduct?.category ?? 'Electronics';
    descriptionController.text = editingProduct?.description ?? '';
    priceController.text = editingProduct?.price?.toString() ?? '';
    brandController.text = editingProduct?.brand ?? '';
    discountController.text = editingProduct?.discountPercent?.toString() ?? '';
    stockController.text = editingProduct?.stock?.toString() ?? '';
    tagsController.text = editingProduct?.tags?.join(', ') ?? '';
    weightController.text = editingProduct?.weight?.toString() ?? '';
    colorsController.text = editingProduct?.colors?.join(', ') ?? '';
    dimensionsController.text = editingProduct?.dimensions ?? '';
    isActive.value = (editingProduct?.isActive ?? true) ? 'Active' : 'Inactive';
    existingImageUrl.value = editingProduct?.image ?? '';
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  //feild clear methode
  void _clearFields() {
    isEditing.value = false;
    editingProduct = null;
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    brandController.clear();
    discountController.clear();
    stockController.clear();
    tagsController.clear();
    weightController.clear();
    colorsController.clear();
    dimensionsController.clear();
    selectedCategory.value = 'Electronics';
    isActive.value = 'Active';
    imageFile.value = null;
    existingImageUrl.value = '';
  }

  Future<void> submit() async {
    if (nameController.text.isEmpty || priceController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Product Name and Price are required',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    // create obj
    final productData = {
      "name": nameController.text,
      "description": descriptionController.text,
      "price": double.tryParse(priceController.text) ?? 0.0,
      "stock": int.tryParse(stockController.text) ?? 0,
      "category": selectedCategory.value,
      "brand": brandController.text,
      "isDiscounted":
          discountController.text.isNotEmpty &&
          (double.tryParse(discountController.text) ?? 0) > 0,
      "discountPercent": double.tryParse(discountController.text) ?? 0.0,
      "tags": tagsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      "isActive": isActive.value == 'Active',
      "weight": double.tryParse(weightController.text) ?? 0.0,
      "colors": colorsController.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList(),
      "dimensions": dimensionsController.text,
    };

    bool success;
    if (isEditing.value) {
      success = await _productController.editProduct(
        editingProduct!.id!,
        productData,
        imageFile.value,
      );
    } else {
      success = await _productController.addProduct(
        productData,
        imageFile.value ?? File(''),
      );
    }

    isLoading.value = false;

    if (success) {
      Get.back();
      _clearFields();
      Get.delete<AddEditProductController>();
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.snackbar(
          'Success',
          isEditing.value
              ? 'Product updated successfully'
              : 'Product created successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(16),
        );
      });
    } else {
      Get.snackbar(
        'Error',
        isEditing.value
            ? 'Failed to update product'
            : 'Failed to create product',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
