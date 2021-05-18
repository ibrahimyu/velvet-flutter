import 'package:flutter/material.dart';
import 'package:velvet/velvet.dart';

typedef ChoiceBuilder<T> = DropdownMenuItem<T> Function(
    BuildContext, Map<String, dynamic> item);

class DataDropdown<T> extends StatefulWidget {
  final T? value;
  final ValueChanged<T?> onChanged;
  final ChoiceBuilder<T> choiceBuilder;
  final HttpDataSource source;
  final String? hintText;
  DataDropdown({
    Key? key,
    this.value,
    required this.onChanged,
    required this.choiceBuilder,
    required this.source,
    this.hintText,
  }) : super(key: key);

  @override
  _DataDropdownState createState() => _DataDropdownState();
}

class _DataDropdownState<T> extends State<DataDropdown<T>> {
  T? value;
  List<Map<String, dynamic>> result = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      hint: widget.hintText != null ? Text('Filter') : null,
      items: [
        DropdownMenuItem<T>(child: Text('All'), value: null),
        ...result
            .map(
              (r) => widget.choiceBuilder(context, r),
            )
            .toList(),
      ],
      onChanged: (val) {
        setState(() {
          value = val;
          widget.onChanged(val);
        });
      },
    );
  }
}
