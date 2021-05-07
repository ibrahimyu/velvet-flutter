import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'paginator.dart';
import 'data_ctrl.dart';
import 'app_bar.dart';
import 'data_list.dart';

import 'types.dart';

class VelvetScaffold extends StatelessWidget {
  final String? title;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool showAppBar;
  final DataBuilder<Map<String, dynamic>>? itemBuilder;
  final DataBuilder<List>? tableBuilder;
  final DataController controller;
  final DataListViewType view;

  final String emptyText;
  final EdgeInsetsGeometry? padding;

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
          controller.refresh();
        },
        onSearch: (q) {
          controller.searchQuery = q;
          controller.refresh();
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
