import 'package:lsd/lsd.dart';
import 'package:provider/provider.dart';

import '../lsd_page_controller.dart';

class SendToServerAction extends LsdAction {
  SendToServerAction(super.lsd);

  late String endpoint;
  late final bool silent;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    endpoint = props["endpoint"];
    silent = props["silent"] ?? false;

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    Map<String, dynamic>? result = await getContext()
        .read<LsdPageController>()
        .sendToServer(endpoint, params);

    if (result != null) {
      return lsd
          .parseAction(Map<String, dynamic>.from(result))
          .perform(getContext, params);
    }
    return result;
  }
}
