import 'package:lsd/lsd.dart';

class ResultAction extends LsdAction {
  ResultAction(super.lsd);

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
