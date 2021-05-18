import 'package:flutter/material.dart';
import 'package:velvet/velvet.dart';

typedef DataBuilder<T> = Widget Function(BuildContext context, T item);

typedef ColumnBuilder = List<DataColumn> Function(DataController controller);
typedef RowBuilder<T> = DataRow Function(T item);
