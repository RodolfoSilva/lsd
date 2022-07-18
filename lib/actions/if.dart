import 'package:lsd/lsd.dart';

class IfAction extends LsdAction {
  IfAction(super.lsd);

  late final dynamic match;
  late final LsdAction action;
  late final LsdAction? thenAction;
  late final LsdAction? elseAction;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    match = props["match"];
    action = lsd.parseAction(props["action"]);
    thenAction = props["then"] != null ? lsd.parseAction(props["then"]) : null;
    elseAction = props["else"] != null ? lsd.parseAction(props["else"]) : null;

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    dynamic result = await action.perform(getContext, params);

    if (match == null && result == null) {
      return thenAction?.perform(getContext, params);
    }

    if (((match == null && result == null) ||
            (result is String && match is String) ||
            (result is num && match is num) ||
            (result is bool && match is bool)) &&
        result == match) {
      return thenAction?.perform(getContext, params);
    }

    return elseAction?.perform(getContext, params);
  }
}
