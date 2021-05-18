import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'paginator.dart';
import 'data_ctrl.dart';
import 'app_bar.dart';
import 'data_list.dart';

import 'types.dart';

class VelvetScaffold extends StatelessWidget {
  /// Title shown in the AppBar. Will be replaced when searching.
  final String? title;

  /// Copied from Scaffold.
  final Widget? floatingActionButton;

  /// Copied from Scaffold.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Determines if the AppBar should be shown or not. Defaults to true.
  final bool showAppBar;

  /// Shows how to render the data in ListView.
  final DataBuilder<Map<String, dynamic>>? itemBuilder;

  /// Shows how to render data in DataTable.
  final DataBuilder<List>? tableBuilder;

  /// The controller responsible to control this VelvetScaffold.
  final DataController controller;
  final DataListViewType view;

  final String emptyText;

  /// ListView or datatable padding
  final EdgeInsetsGeometry? padding;

  /// Extra actions to be included in AppBar's actions.
  final List<Widget>? actions;

  VelvetScaffold({
    Key? key,
    this.title,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.showAppBar = false,
    this.itemBuilder,
    this.tableBuilder,
    this.emptyText = 'No data.',
    this.padding,
    required this.controller,
    this.actions,
    this.view = DataListViewType.table,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VelvetAppBar(
        title: title,
        onRefresh: () {
          controller.reload();
        },
        onSearch: (q) {
          controller.searchQuery = q;
          controller.reload();
        },
        actions: actions,
      ),
      body: Obx(
        () => VelvetDataList(
          padding: padding,
          itemBuilder: itemBuilder,
          tableBuilder: tableBuilder,
          emptyText: emptyText,
          data: controller.data.value,
          view: view,
        ),
      ),
      bottomNavigationBar: VelvetPaginator(controller: controller),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
