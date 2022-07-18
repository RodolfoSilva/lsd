import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

class ListViewWidget extends LsdWidget {
  late LsdWidget child;
  late int padding;

  late List<LsdWidget> items;
  late LsdAction? onLoadMore;

  ListViewWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    items = List<Map<String, dynamic>>.from(props["items"])
        .map((e) => lsd.parseWidget(e))
        .toList();

    onLoadMore = props["onLoadMore"] != null
        ? lsd.parseAction(props["onLoadMore"])
        : null;
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return _ListViewWidget(
      items: items,
      lsd: lsd,
      onLoadMore: onLoadMore,
    );
  }
}

class _ListViewWidget extends StatefulWidget {
  const _ListViewWidget({
    Key? key,
    required this.items,
    this.onLoadMore,
    required this.lsd,
  }) : super(key: key);

  final List<LsdWidget> items;
  final Lsd lsd;
  final LsdAction? onLoadMore;

  @override
  State<_ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<_ListViewWidget> {
  List<LsdWidget> widgets = [];
  final ScrollController _scrollController = ScrollController();
  LsdAction? _onLoadMore;
  bool _isLoading = false;

  @override
  void initState() {
    widgets = widget.items;
    _onLoadMore = widget.onLoadMore;

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels !=
          _scrollController.position.maxScrollExtent) {
        return;
      }

      _fetchMore();
    });
    super.initState();
  }

  void _fetchMore() async {
    if (_isLoading) {
      return;
    }
    try {
      setState(() {
        _isLoading = true;
      });
      final result = await _onLoadMore?.perform(() => context, null);

      if (result is! Map<String, dynamic>) {
        return;
      }

      if (result.containsKey("onLoadMore")) {
        _onLoadMore = result["onLoadMore"];
      }

      if (result.containsKey("items")) {
        setState(() {
          final items = List<LsdWidget>.from(result["items"]);
          widgets.addAll(items);
        });
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: widgets.length + 1,
      itemBuilder: ((context, index) {
        if (index >= widgets.length) {
          return Container(
            child: _isLoading ? const Text("Loading...") : null,
          );
        }
        return widgets[index].toWidget(context);
      }),
    );
  }
}
