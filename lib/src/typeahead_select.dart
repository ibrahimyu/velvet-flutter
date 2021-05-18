import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:velvet/src/api.dart';
import 'package:velvet/velvet.dart';

class TypeaheadSelect<T> extends StatefulWidget {
  final T? initialValue;
  final ValueChanged<T?> onChanged;
  final DataBuilder selectionBuilder;
  final String? labelText;
  final String url;
  final Map<String, String>? query;

  TypeaheadSelect({
    Key? key,
    this.initialValue,
    required this.onChanged,
    required this.selectionBuilder,
    this.labelText,
    required this.url,
    this.query,
  }) : super(key: key);

  @override
  _TypeaheadSelectState createState() => _TypeaheadSelectState();
}

class _TypeaheadSelectState<T> extends State<TypeaheadSelect<T>> {
  T? value;

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      return Row(
        children: [
          Expanded(child: widget.selectionBuilder(context, value)),
          IconButton(
              onPressed: () {
                setState(() {
                  value = null;
                });
                widget.onChanged(null);
              },
              icon: Icon(Icons.cancel))
        ],
      );
    } else {
      var query = {'paginate': 'false'}..addAll(widget.query ?? {});
      return TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(labelText: widget.labelText),
        ),
        suggestionsCallback: (pattern) async {
          var response = await Api().get(widget.url, query: query);
          var list = response.body;
          return list;
        },
        itemBuilder: (context, suggest) {
          return widget.selectionBuilder(context, suggest);
        },
        onSuggestionSelected: (suggest) {
          setState(() {
            value = suggest as T;
          });
          widget.onChanged(suggest as T);
        },
      );
    }
  }
}
