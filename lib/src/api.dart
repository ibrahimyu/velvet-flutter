import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';

class Api extends GetConnect {
  static String prefix = '';

  Api() {
    httpClient.baseUrl = Api.prefix;
    httpClient.defaultDecoder = (x) => x;
    httpClient.addRequestModifier<dynamic>((request) async {
      String token = GetStorage().read('api_token') ?? '';

      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      return request;
    });

    httpClient.addResponseModifier((request, response) {
      if (response.hasError) {
        Get.snackbar('Error', 'Terjadi kesalahan. Silakan coba kembali.');
      }
    });
  }
}

Map<String, dynamic> stripNull(Map<String, dynamic> map) {
  map.removeWhere((key, value) {
    if (value == null) {
      return true;
    }

    if (value is String && value.isEmpty) {
      return true;
    }

    return false;
  });

  return map;
}
