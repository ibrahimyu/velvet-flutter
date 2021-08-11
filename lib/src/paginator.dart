import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data_ctrl.dart';

class VelvetPaginator extends StatelessWidget {
  final DataController controller;
  const VelvetPaginator({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          child: controller.data.value != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Menampilkan ${controller.data.value!.from} - ${controller.data.value!.to}, total ${controller.data.value!.total}',
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_left),
                      onPressed: () {
                        if (controller.data.value!.currentPage > 1) {
                          controller.data.value!.currentPage--;
                          controller.reload();
                        }
                      },
                    ),
                    Text(
                      "Halaman ${controller.data.value!.currentPage} dari ${controller.data.value!.totalPage}",
                      style: const TextStyle(fontSize: 12.0),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_right),
                      onPressed: () {
                        if (controller.data.value!.currentPage <
                            controller.data.value!.totalPage) {
                          controller.data.value!.currentPage++;
                          controller.reload();
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
