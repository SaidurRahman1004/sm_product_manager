import 'dart:convert';
import 'dart:io';
import '../../core/constants/api_constants.dart';
import '../../core/network/network_info.dart';
import '../data_sources/local/sqflite_helper.dart';
import '../data_sources/remote/api_client.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ApiClient _apiClient = ApiClient();

  // get all products Handles API and offline cache
  Future<List<ProductModel>> getProducts() async {
    final bool isOnline = await NetworkInfo.isConnected();

    if (isOnline) {
      try {
        final response = await _apiClient.get(ApiConstants.baseUrl + ApiConstants.products);
        final data = jsonDecode(response.body);

        if (response.statusCode == 200 && data['success'] == true) {
          final List<dynamic> productsJson = data['data'];
          final List<ProductModel> products = productsJson.map((json) => ProductModel.fromJson(json)).toList();

          // save local cache for offline use
          await SqfliteHelper.cacheProducts(products);
          return products;
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch products');
        }
      } catch (e) {
        // local cache if API fails
        return await SqfliteHelper.getCachedProducts();
      }
    } else {
      // Return local cache if offline
      return await SqfliteHelper.getCachedProducts();
    }
  }

  // create Product
  Future<bool> createProduct(Map<String, dynamic> productData, File imageFile) async {
    try {
      final response = await _apiClient.multipartRequest(
        ApiConstants.baseUrl + ApiConstants.products,
        method: 'POST',
        fields: {'data': jsonEncode(productData)},
        imageFile: imageFile,
        fileKey: 'image',
      );
      final data = jsonDecode(response.body);
      return (response.statusCode == 201 || response.statusCode == 200) && data['success'] == true;
    } catch (e) {
      return false;
    }
  }

  // update
  Future<bool> updateProduct(String productId, Map<String, dynamic> productData, File? imageFile) async {
    try {
      final response = await _apiClient.multipartRequest(
        '${ApiConstants.baseUrl}${ApiConstants.products}/$productId',
        method: 'PUT',
        fields: {'data': jsonEncode(productData)},
        imageFile: imageFile,
        fileKey: 'image', // File upload key
      );
      final data = jsonDecode(response.body);
      return response.statusCode == 200 && data['success'] == true;
    } catch (e) {
      return false;
    }
  }

  // Delete
  Future<bool> deleteProduct(String productId) async {
    try {
      final response = await _apiClient.delete('${ApiConstants.baseUrl}${ApiConstants.products}/$productId');
      final data = jsonDecode(response.body);
      return response.statusCode == 200 && data['success'] == true;
    } catch (e) {
      return false;
    }
  }
}