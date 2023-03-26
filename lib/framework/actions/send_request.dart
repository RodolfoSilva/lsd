import 'package:lsd/lsd.dart';
import 'package:provider/provider.dart';

import '../controllers/screen_controller.dart';
import '../models/request.dart';

class SendRequestAction extends LsdAction {
  SendRequestAction(super.lsd);

  late final Request request;
  late LsdAction? callback;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    request = Request.fromJson(Map<String, dynamic>.from(props["request"]));
    callback =
        props["callback"] != null ? lsd.parseAction(props["callback"]) : null;

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    Map<String, dynamic>? result = await getContext()
        .read<ScreenController>()
        .sendRequestToServer(request.copyWith(data: params));

    if (callback != null) {
      return callback!.perform(getContext, params);
    }

    if (result != null) {
      return lsd
          .parseActionOrNull(Map<String, dynamic>.from(result))
          ?.perform(getContext, params);
    }

    return null;
  }
}
