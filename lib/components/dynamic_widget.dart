import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import '../api_service.dart';
import 'lsd_route_controller.dart';
import 'lsd_route_controller_provider.dart';

class DynamicWidget extends LsdWidget {
  late String path;
  final LsdRouteController _routeController = LsdRouteController();
  final ApiService apiService;

  DynamicWidget(super.lsd, this.apiService);

  @override
  LsdWidget fromJson(Map<String, dynamic> props) {
    path = props["path"];
    return super.fromJson(props);
  }

  @override
  Widget build(BuildContext context) {
    return LsdRouteControllerProvider(
      controller: _routeController,
      child: _DynamicWidget(
        apiService: apiService,
        path: path,
        lsd: lsd,
      ),
    );
  }
}

class _DynamicWidget extends StatefulWidget {
  const _DynamicWidget({
    Key? key,
    required this.path,
    required this.apiService,
    required this.lsd,
  }) : super(key: key);

  final String path;
  final Lsd lsd;
  final ApiService apiService;

  @override
  State<_DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<_DynamicWidget> {
  Future<Map<String, dynamic>?>? _widget;

  StreamSubscription<LsdRouteEvent>? _routeSubscription;

  @override
  void initState() {
    super.initState();

    _widget = widget.apiService.get(widget.path);

    Future.microtask(() {
      _routeSubscription =
          LsdRouteControllerProvider.of(context).stream.listen((event) {
        if (event is LsdRouteEventLoad) {
          setState(() {
            _widget = widget.apiService.get(widget.path);
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _routeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
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
