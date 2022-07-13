import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';
import 'package:serview/loader.dart';

class DynamicWidget extends LsdWidget {
  late String path;

  DynamicWidget(super.lsd);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    path = props["path"];
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return _DynamicWidget(
      path: path,
      lsd: lsd,
    );
  }
}

class _DynamicWidget extends StatefulWidget {
  const _DynamicWidget({Key? key, required this.path, required this.lsd})
      : super(key: key);

  final String path;
  final Lsd lsd;

  @override
  State<_DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<_DynamicWidget> {
  late Future<Map<String, dynamic>> _widget;

  @override
  void initState() {
    super.initState();

    _widget = load(widget.path);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _widget,
      builder: (context, data) {
        if (data.connectionState != ConnectionState.done) {
          return widget.lsd.renderLoading(context);
        }

        if (data.hasError) {
          return widget.lsd.renderError(context, data.error);
        }

        return LsdSafeWidgetBuilder(
          lsd: widget.lsd,
          element: data.data!,
        );
      },
    );
  }
}
