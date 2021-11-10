import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:velvet/src/api.dart';
import 'package:velvet/velvet.dart';

class TypeaheadSelect extends StatefulWidget {
  final Map<String, dynamic>? initialValue;
  final ValueChanged<Map<String, dynamic>?> onChanged;
  final DataBuilder selectionBuilder;
  final String? labelText;
  final String url;
  final Map<String, String>? query;
  final bool nullable;

  const TypeaheadSelect({
    Key? key,
    this.initialValue,
    required this.onChanged,
    required this.selectionBuilder,
    this.labelText,
    required this.url,
    this.query,
    this.nullable = true,
  }) : super(key: key);

  @override
  _TypeaheadSelectState createState() => _TypeaheadSelectState();
}

class _TypeaheadSelectState extends State<TypeaheadSelect> {
  Map<String, dynamic>? value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    if (value != null) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xfff2f4f9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.labelText != null)
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(widget.labelText ?? ''),
              ),
            Row(
              children: [
                Expanded(child: widget.selectionBuilder(context, value)),
                if (widget.nullable)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        value = null;
                      });
                      widget.onChanged(null);
                    },
                    icon: const Icon(Icons.cancel),
                  )
              ],
            ),
          ],
        ),
      );
    } else {
      var query = {'paginate': 'false'}..addAll(widget.query ?? {});
      return TypeAheadFormField<Map<String, dynamic>>(
        textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(labelText: widget.labelText),
        ),
        suggestionsCallback: (pattern) async {
          var response = await Api().get(widget.url, query: query);
          var list = (response.body as List)
              .map((i) => Map<String, dynamic>.from(i))
              .toList(); //as List<Map<String, dynamic>>);
          return list;
        },
        itemBuilder: (context, suggest) {
          return widget.selectionBuilder(context, suggest);
        },
        onSuggestionSelected: (suggest) {
          setState(() {
            value = suggest;
          });
          widget.onChanged(suggest);
        },
      );
    }
  }
}
