import 'package:flutter/material.dart';
import 'package:velvet/velvet.dart';

typedef OptionalItemBuilder = Widget Function(
    BuildContext context, Map<String, dynamic>? itemData);

/// Convenience widget for data forms.
class ShowPage<T> extends StatefulWidget {
  final String url;
  final dynamic id;
  final OptionalItemBuilder builder;
  final String title;

  final List<Widget>? actions;
  const ShowPage({
    Key? key,
    required this.builder,
    this.title = 'View Item',
    required this.url,
    this.id,
    this.actions,
  }) : super(key: key);

  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState<T> extends State<ShowPage<T>> {
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: widget.actions,
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
}
