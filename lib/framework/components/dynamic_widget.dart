import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';
import 'package:provider/provider.dart';

import '../lsd_page_controller.dart';
import '../providers/busy_controller.dart';
import '../services/api_service.dart';

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
    return ChangeNotifierProxyProvider<BusyController, LsdPageController>(
      create: (context) => LsdPageController(
        path: path,
        busyController: context.read<BusyController>(),
        apiService: context.read<ApiService>(),
      ),
      update: (context, busyController, pageController) =>
          pageController!..busyController = busyController,
      builder: (context, child) {
        final lsd = Provider.of<Lsd>(context);
        final controller = Provider.of<LsdPageController>(context);

        if (controller.isLoading) {
          return lsd.renderLoading(context);
        }

        if (controller.hasError) {
          return lsd.renderError(context, controller.error);
        }

        return LsdSafeWidgetBuilder(
          lsd: lsd,
          element: controller.body!,
        );
      },
    );
  }
}
