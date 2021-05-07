import 'package:get/get.dart';
import 'http_data_source.dart';
import 'paginated_data.dart';

class DataController extends GetxController {
  HttpDataSource source;

  String searchQuery = '';
  String sort = '';

  bool isLoading = false;
  bool hasData = false;
  bool hasError = false;
  String error = '';
  Map<String, String> params = {};

  var data = Rx<PaginatedData?>(null);

  final List<String> filters = [];
  final List<String> sortables = [];

  bool canMulti = true;
  var multi = false.obs;
  var sortAscending = false.obs;
  Set selected = Set();

  Rx<int?> sortColumnIndex = Rx<int?>(null);

  DataController({
    required this.source,
  }) {
    refresh();
  }

  void refresh() async {
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
