import 'package:flutter/material.dart';
import 'package:velvet/velvet.dart';

import 'types.dart';

enum DataListViewType {
  list,
  table,
}

class VelvetDataList extends StatelessWidget {
  final DataBuilder<Map<String, dynamic>>? itemBuilder;
  final DataBuilder<List>? tableBuilder;
  final PaginatedData? data;

  final String emptyText;
  final EdgeInsetsGeometry? padding;

  final DataListViewType view;

  const VelvetDataList({
    required this.data,
    Key? key,
    this.itemBuilder,
    this.tableBuilder,
    this.emptyText = 'Nothing here yet.',
    this.padding,
    this.view = DataListViewType.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (data!.data.isEmpty) {
          return Center(
            child: Text(emptyText),
          );
        }

        if (tableBuilder != null && itemBuilder != null) {
          // if both builder exist, take the value from variable.
          // otherwise just use supplied builder.
        }

        if (view == DataListViewType.table) {
          return SingleChildScrollView(
            child: tableBuilder!(context, data!.data),
          );
        } else if (view == DataListViewType.list) {
          return ListView.builder(
            padding: padding,
            itemBuilder: (context, index) =>
                itemBuilder!(context, data!.data[index]),
            itemCount: data!.data.length,
          );
        }

        return const Center(
          child: Text('No view is selected.'),
        );
      },
    );
  }
}
