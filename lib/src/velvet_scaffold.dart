import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'paginator.dart';
import 'data_list_ctrl.dart';
import 'smart_appbar.dart';
import 'data_list.dart';

import 'types.dart';

class VelvetScaffold extends StatelessWidget {
  final String? title;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool showAppBar;
  //final DataSource source;
  final DataBuilder<Map<String, dynamic>>? itemBuilder;
  final DataBuilder<List>? tableBuilder;
  final DataListController controller;

  final String emptyText;
  final EdgeInsetsGeometry? padding;

  VelvetScaffold({
    Key? key,
    this.title,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.showAppBar = false,
    //required this.source,
    this.itemBuilder,
    this.tableBuilder,
    this.emptyText = 'No data.',
    this.padding,
    required this.controller,
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
      ),
      body: Obx(
        () => VelvetDataList(
          padding: padding,
          itemBuilder: itemBuilder,
          tableBuilder: tableBuilder,
          emptyText: emptyText,
          data: controller.data.value,
        ),
      ),
      bottomNavigationBar: VelvetPaginator(controller: controller),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
