import 'package:flutter/material.dart';

/// An appbar for data list.
class VelvetAppBar extends StatefulWidget with PreferredSizeWidget {
  /// The title will be displayed on the AppBar.
  final String? title;

  /// You can put additional actions in the AppBar.
  /// The default actions are Search and Filter.
  final List<Widget>? actions;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onRefresh;
  VelvetAppBar({
    Key? key,
    this.title,
    this.actions,
    this.onSearch,
    this.onRefresh,
  }) : super(key: key);

  @override
  _VelvetAppBarState createState() => _VelvetAppBarState();

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _VelvetAppBarState extends State<VelvetAppBar> {
  final TextEditingController queryCtrl = TextEditingController();
  var isSearching = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching
          ? TextField(
              autofocus: true,
              controller: queryCtrl,
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                  },
                ),
              ),
              onEditingComplete: () => doSearch(),
              onSubmitted: (val) => doSearch(),
            )
          : Text(widget.title ?? ''),
      actions: [
        if (widget.actions != null) ...widget.actions!,
        IconButton(
          icon: isSearching ? Icon(Icons.cancel) : Icon(Icons.search),
          onPressed: () {
            setState(() {
              isSearching = !isSearching;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            if (widget.onRefresh != null) widget.onRefresh!();
          },
        )
      ],
    );
  }

  void doSearch() {
    if (widget.onSearch != null && queryCtrl.text.length > 0) {
      widget.onSearch!(queryCtrl.text);
    }
  }
}
