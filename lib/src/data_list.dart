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

  VelvetDataList({
    required this.data,
    this.itemBuilder,
    this.tableBuilder,
    this.emptyText = 'Nothing here yet.',
    this.padding,
    this.view = DataListViewType.table,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (data == null) {
          return Center(child: CircularProgressIndicator());
        }

        if (data!.data.length == 0) {
          return Center(
            child: Text(emptyText),
          );
        }

        if (tableBuilder != null && itemBuilder != null) {
          // if both builder exist, take the value from variable.
          // otherwise just use supplied builder.
        }

        if (view == DataListViewType.table) {
          return tableBuilder!(context, data!.data);
        } else if (view == DataListViewType.list) {
          return ListView.builder(
            padding: padding,
            itemBuilder: (context, index) =>
                itemBuilder!(context, data!.data[index]),
            itemCount: data!.data.length,
          );
        }

        return Center(
          child: Text('No view is selected.'),
        );
      },
    );
  }
}
