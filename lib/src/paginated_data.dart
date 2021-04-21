/// This is Laravel's resource controller data structure.
/// To adapt to other data sources, extend this class
class PaginatedData {
  List data = [];

  int currentPage = 1;
  int totalPage = 1;

  int from = 1;
  int to = 1;
  int total = 1;

  PaginatedData({
    required this.data,
    this.currentPage = 1,
    this.totalPage = 1,
    this.from = 0,
    this.to = 0,
    this.total = 0,
  });

  factory PaginatedData.fromMap(Map<String, dynamic> map) {
    return PaginatedData(
      data: map['data'],
      currentPage: map['current_page'],
      totalPage: map['last_page'],
      from: map['from'],
      to: map['to'],
      total: map['total'],
    );
  }
}
