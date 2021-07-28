import 'package:flutter/material.dart';
import 'package:velvet/src/api.dart';

import 'data_source.dart';
import 'paginated_data.dart';

class HttpDataSource extends DataSource {
  final String url;
  final Map<String, dynamic>? query;

  HttpDataSource({required this.url, this.query});

  @override
  Future<PaginatedData?> getData({
    Map<String, dynamic>? query,
    ValueChanged<String>? onError,
  }) async {
    Map<String, dynamic> queryMap = (this.query ?? {})
      ..addAll(query ?? {})
      ..addAll({
        'page': data?.currentPage.toString() ?? '',
      });

    var response = await Api().get(url, query: queryMap);

    if (response.hasError) {
      if (onError != null) {
        onError(response.body);
      }
      return null;
    }

    data = PaginatedData.fromMap(response.body);

    return data;
  }

  Future<bool> delete(dynamic id, {ValueChanged? onError}) async {
    var response = await Api().delete('$url/$id');

    if (response.hasError) {
      if (onError != null) {
        onError(response.body);
      }
      return false;
    }

    return true;
  }

  Future store(Map<String, dynamic> data, {ValueChanged? onError}) async {
    var response = await Api().post(url, data);

    if (response.hasError) {
      if (onError != null) {
        onError(response.body);
      }
      return false;
    }

    return response.body;
  }

  Future update(dynamic id, Map<String, dynamic> data,
      {ValueChanged? onError}) async {
    var response = await Api().put('$url/$id', data);

    if (response.hasError) {
      if (onError != null) {
        onError(response.body);
      }
      return false;
    }

    return response.body;
  }

  Future find(dynamic id, {ValueChanged? onError}) async {
    var response = await Api().get('$url/$id');

    if (response.hasError) {
      if (onError != null) {
        onError(response.body);
      }
      return false;
    }

    return response.body;
  }
}
