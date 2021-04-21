import 'package:get/get.dart';
import 'data_source.dart';
import 'paginated_data.dart';

class DataListController extends GetxController {
  DataSource source;

  String searchQuery = '';
  String sort = '';
  bool desc = false;

  bool isLoading = false;
  bool hasData = false;
  bool hasError = false;
  String error = '';

  var data = Rx<PaginatedData?>(null);

  final List<String> filters = [];
  final List<String> sortables = [];

  DataListController({
    required this.source,
  }) {
    refresh();
  }

  void refresh() async {
    data.value = await source.getData(query: {
      //
    });
  }
}
