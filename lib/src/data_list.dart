import 'package:flutter/material.dart';
import 'package:velvet/velvet.dart';

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

        return OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.landscape && tableBuilder != null) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: ScrollController(),
                  child: tableBuilder!(context, data!.data),
                ),
              );
            } else {
              return ListView.builder(
                controller: ScrollController(),
                padding: padding,
                itemBuilder: (context, index) =>
                    itemBuilder!(context, data!.data[index]),
                itemCount: data!.data.length,
              );
            }
          },
        );
      },
    );
  }
}
