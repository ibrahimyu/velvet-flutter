import 'paginated_data.dart';

abstract class DataSource {
  PaginatedData? data;

  Future<PaginatedData?> getData({Map<String, String>? query});
}
