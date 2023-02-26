import 'package:lsd/lsd.dart';

class ActionResult extends LsdAction {
  ActionResult(super.lsd);

  late final dynamic result;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    result = props["result"];

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    return result;
  }
}
