import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final _scrollCtrl = ScrollController();

  VelvetDataList({
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

        if (!GetPlatform.isMobile && this.tableBuilder != null) {
          return SingleChildScrollView(
            controller: _scrollCtrl,
            child: tableBuilder!(context, data!.data),
          );
        } else {
          return ListView.builder(
            controller: _scrollCtrl,
            padding: padding,
            itemBuilder: (context, index) =>
                itemBuilder!(context, data!.data[index]),
            itemCount: data!.data.length,
          );
        }
      },
    );
  }
}
