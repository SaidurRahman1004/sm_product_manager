import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../../../core/constants/app_strings.dart';
import '../local/shared_prefs_helper.dart';

class ApiClient {
  final int timeoutInSeconds = 30;
  //manage Headers,token,isMultipart
  Future<Map<String, String>> _getHeaders({bool isMultipart = false}) async {
    final token = SharedPrefsHelper.getToken();
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    if (!isMultipart) {
      headers['Content-Type'] = 'application/json';
    }

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  // GET Request
  Future<http.Response> get(String uri) async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(
        Uri.parse(uri),
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return response;
    } catch (e) {
      throw Exception(AppStrings.netError);
    }
  }

  // POST Request
  Future<http.Response> post(String uri, {Map<String, dynamic>? body}) async {
    try {
      final headers = await _getHeaders();
      final response = await http.post(
        Uri.parse(uri),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return response;
    } catch (e) {
      throw Exception(AppStrings.netError);
    }
  }

  // PUT Request
  Future<http.Response> put(String uri, {Map<String, dynamic>? body}) async {
    try {
      final headers = await _getHeaders();
      final response = await http.put(
        Uri.parse(uri),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return response;
    } catch (e) {
      throw Exception(AppStrings.netError);
    }
  }

  // DELETE Request
  Future<http.Response> delete(String uri) async {
    try {
      final headers = await _getHeaders();
      final response = await http.delete(
        Uri.parse(uri),
        headers: headers,
      ).timeout(Duration(seconds: timeoutInSeconds));
      return response;
    } catch (e) {
      throw Exception(AppStrings.netError);
    }
  }

  // multipartRequest Img Upload
  Future<http.Response> multipartRequest(
      String uri, {
        required String method,
        Map<String, String>? fields,
        File? imageFile,
        String fileKey = 'image',
      }) async {
    try {
      final headers = await _getHeaders(isMultipart: true);
      var request = http.MultipartRequest(method, Uri.parse(uri));
      request.headers.addAll(headers);
//add extra feilds with image if needes
      if (fields != null) {
        request.fields.addAll(fields);
      }
      //files
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(fileKey, imageFile.path),
        );
      }

      var streamedResponse = await request.send().timeout(Duration(seconds: timeoutInSeconds));
      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      throw Exception(AppStrings.netErrorImg);
    }
  }
}