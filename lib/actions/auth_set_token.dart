import 'package:lsd/lsd.dart';

import '../auth.dart';

class AuthSetTokenAction extends LsdAction {
  AuthSetTokenAction(super.lsd, this.auth);

  final Auth auth;
  late String? token;
  late LsdAction? after;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    token = props["token"];
    after = props["after"] != null ? lsd.parseAction(props["after"]) : null;
    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    if (token != null) {
      await auth.setToken(token!);
    } else {
      await auth.removeToken();
    }

    if (after != null) {
      return after!.perform(getContext, params);
    }

    return null;
  }
}
