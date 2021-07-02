import 'package:get/get.dart';
import 'http_data_source.dart';
import 'paginated_data.dart';

class DataController extends GetxController {
  /// Sets if items can be multi-selected.
  final bool canMulti;

  /// The data source for this controller. Usually a HttpDataSource,
  /// but might implement other sources as well.
  final HttpDataSource source;

  /// Current search query.
  String searchQuery = '';

  /// Current sort column - usually by a table column name.
  String sort = '';

  /// Usually used to show progress indicators when loading data.
  var isLoading = false.obs;

  /// If there is an error when fetching data, this will return true.
  bool hasError = false;
  String error = '';
  Map<String, String> params = {};

  var data = Rx<PaginatedData?>(null);

  final List<String> filters = [];
  final List<String> sortables = [];

  /// This is for maintaining states.
  var multi = false.obs;
  var sortAscending = false.obs;
  Set selected = {};

  Rx<int?> sortColumnIndex = Rx<int?>(null);

  bool get hasData {
    return data.value != null;
  }

  DataController({
    required this.source,
    this.canMulti = true,
  }) {
    reload();
  }

  Future<void> reload() async {
    isLoading.value = true;
    await loadData();
    isLoading.value = false;
  }

  Future<void> loadData() async {
    data.value = await source.getData(
        query: {
      'q': searchQuery,
      'sort': sort,
      'desc': sortAscending.isFalse ? '1' : '0',
    }..addAll(params));
  }

  void sortColumn(int index, String columnName, bool desc) {
    sortColumnIndex.value = index;
    sortAscending.value = desc;
    sort = columnName;

    refresh();
  }
}
