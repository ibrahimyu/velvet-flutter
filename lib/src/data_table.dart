import 'package:flutter/material.dart';
import 'package:velvet/velvet.dart';

class VelvetDataTable extends StatelessWidget {
  final DataController controller;
  final List<DataColumn> columns;
  final RowBuilder rowBuilder;

  const VelvetDataTable({
    Key? key,
    required this.controller,
    required this.columns,
    required this.rowBuilder,
  }) : super(key: key);

  @override
  DataTable build(BuildContext context) {
    return DataTable(
      columns: [
        ...columns,
        // This should allow for item actions and multiple actions.
        if (controller.multi.value == false)
          const DataColumn(
            label: Text('Actions'),
          ),
      ],
      rows: controller.hasData
          ? controller.data.value!.data.map((r) => rowBuilder(r)).toList()
          : [],
    );
  }
}
