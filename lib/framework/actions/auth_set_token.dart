import 'package:lsd/lsd.dart';
import 'package:provider/provider.dart';

import '../services/auth_service.dart';

class AuthSetTokenAction extends LsdAction {
  AuthSetTokenAction(super.lsd);

  late String? token;
  late LsdAction? callback;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    token = props["token"];
    callback =
        props["callback"] != null ? lsd.parseAction(props["callback"]) : null;
    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    final authService = getContext().read<AuthService>();
    if (token != null) {
      await authService.setToken(token!);
    } else {
      await authService.removeToken();
    }

    if (callback != null) {
      return callback!.perform(getContext, params);
    }

    return null;
  }
}
