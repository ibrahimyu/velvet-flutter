import 'package:get/get_connect/connect.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';

class Api extends GetConnect {
  static String get prefix {
    return env['API_BASE_URL'] ?? '';
  }

  Api() {
    httpClient.baseUrl = env['API_BASE_URL'];
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
        print(response.body);
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
