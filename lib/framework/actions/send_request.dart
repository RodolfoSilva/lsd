import 'package:lsd/lsd.dart';
import 'package:provider/provider.dart';

import '../lsd_page_controller.dart';
import '../models/request.dart';

class SendRequestAction extends LsdAction {
  SendRequestAction(super.lsd);

  late final Request request;
  late final bool silent;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    request = Request.fromJson(Map<String, dynamic>.from(props["request"]));
    silent = props["silent"] ?? false;

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    Map<String, dynamic>? result = await getContext()
        .read<LsdPageController>()
        .sendRequestToServer(request.copyWith(data: params));

    if (result != null) {
      return lsd
          .parseActionOrNull(Map<String, dynamic>.from(result))
          ?.perform(getContext, params);
    }
    return result;
  }
}
