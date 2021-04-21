import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data_list_ctrl.dart';

class VelvetPaginator extends GetView<DataListController> {
  final DataListController controller;
  const VelvetPaginator({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          child: controller.data.value != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                            'Showing ${controller.data.value!.from} - ${controller.data.value!.to}, ${controller.data.value!.total} total'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_left),
                      onPressed: () {
                        if (controller.data.value!.currentPage > 1) {
                          controller.data.value!.currentPage--;
                          controller.refresh();
                        }
                      },
                    ),
                    Text(
                        "Page ${controller.data.value!.currentPage} of ${controller.data.value!.totalPage}"),
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      onPressed: () {
                        if (controller.data.value!.currentPage <
                            controller.data.value!.totalPage) {
                          controller.data.value!.currentPage++;
                          controller.refresh();
                        }
                      },
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
