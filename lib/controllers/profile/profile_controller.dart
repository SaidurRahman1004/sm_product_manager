import 'dart:convert';
import 'package:get/get.dart';
import '../../core/constants/api_constants.dart';
import '../../data/data_sources/remote/api_client.dart';
import '../../data/models/user_model.dart';

class ProfileController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // store user data
  var user = Rxn<UserModel>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMyProfile(); // Load user dAta when the controller is initialized
  }

  Future<void> fetchMyProfile() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get(
        ApiConstants.baseUrl + ApiConstants.profile,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        user.value = UserModel.fromJson(data['data']);
      } else {
        Get.snackbar('Error', data['message'] ?? 'Failed to load profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'Network error while loading profile');
    } finally {
      isLoading.value = false;
    }
  }
}
