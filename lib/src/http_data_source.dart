import 'package:flutter/material.dart';
import 'package:velvet/src/api.dart';

import 'data_source.dart';
import 'paginated_data.dart';

class HttpDataSource extends DataSource {
  final String url;

  HttpDataSource({required this.url});

  Future<PaginatedData?> getData({
    Map<String, String>? query,
    ValueChanged<String>? onError,
  }) async {
    Map<String, String> queryMap = (query ?? {})
      ..addAll({
        'page': data?.currentPage.toString() ?? '',
      });

    print('Getting data: ' + url);
    var response = await Api().get(url, query: queryMap);

    if (response.hasError && onError != null) {
      onError(response.body);

      return null;
    }

    data = PaginatedData.fromMap(response.body);

    return data;
  }
}
