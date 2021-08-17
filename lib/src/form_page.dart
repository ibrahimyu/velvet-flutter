import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velvet/velvet.dart';

typedef OptionalItemBuilder = Widget Function(
    BuildContext context, Map<String, dynamic>? itemData);

/// Convenience widget for data forms.
class FormPage<T> extends StatefulWidget {
  final String url;
  final dynamic id;
  final OptionalItemBuilder builder;
  final String addTitle;
  final String editTitle;
  final VoidCallback? onSave;
  const FormPage({
    Key? key,
    required this.builder,
    this.addTitle = 'Add Item',
    this.editTitle = 'Edit Item',
    this.onSave,
    required this.url,
    this.id,
  }) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState<T> extends State<FormPage<T>> {
  Map<String, dynamic> data = {};
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? widget.addTitle : widget.editTitle),
        actions: [
          TextButton.icon(
            onPressed: !_saving
                ? () async {
                    setState(() {
                      _saving = true;
                    });

                    if (widget.onSave != null) {
                      widget.onSave!();
                    }

                    await save(data);

                    setState(() {
                      _saving = false;
                    });
                  }
                : null,
            icon: _saving
                ? const CircularProgressIndicator()
                : const Icon(Icons.save),
            label: Text(_saving ? 'Saving' : 'Save'),
          )
        ],
      ),
      body: widget.builder(context, data),
    );
  }

  Future<void> fetch() async {
    var response = await Api().get("url/${widget.id}");

    if (response.isOk) {
      setState(() {
        data = response.body;
      });
    }
  }

  Future<void> save(Map<String, dynamic> data) async {
    var response = await Api().post(widget.url, data);

    if (response.isOk) {
      Get.back();
      Get.snackbar('Success', 'Data saved.');
    } else {
      Get.snackbar('Error', response.body);
    }
  }
}
