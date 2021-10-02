import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';

class Api extends GetConnect {
  static String prefix = '';

  Api() {
    httpClient.baseUrl = Api.prefix;
    httpClient.addRequestModifier<dynamic>((request) async {
      String token = GetStorage().read('api_token') ?? '';

      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      return request;
    });

    httpClient.addResponseModifier((request, response) {
      if (response.hasError) {
        log(response.bodyString ?? 'Error HTTP');
      }

      return response;
    });
  }

  static String getToken() {
    return GetStorage().read('api_token') ?? '';
  }

  Future<Response> uploadFile(String urlPath, List<int> file) {
    final form = FormData({
      'file': MultipartFile(file, filename: 'file'),
    });
    return post(urlPath, form);
  }
}

Map<String, dynamic> stripNull(Map<String, dynamic> map) {
  map.removeWhere((key, value) {
    if (value == null) {
      return true;
    }

    if (value is String && (value.isEmpty || value == 'null')) {
      return true;
    }

    return false;
  });

  return map;
}

extension ApiMapUtils on Map<String, dynamic> {
  Map<String, dynamic> clean() => stripNull(this);

  Map<String, dynamic> attachFile(File? file,
      {String? filename, String field = 'photo'}) {
    if (file != null) {
      this[field] = MultipartFile(file.readAsBytesSync(),
          filename: filename ?? file.path);
    }
    return this;
  }
}
