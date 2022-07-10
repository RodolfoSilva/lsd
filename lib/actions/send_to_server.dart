import 'package:flutter/material.dart';
import 'package:lsd/lsd.dart';

import '../loader.dart';

class SendToServerAction extends LsdAction {
  SendToServerAction(super.lsd, this.apiService);

  final ApiService apiService;
  late String endpoint;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    endpoint = props["endpoint"] ?? "Required!";

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(
    BuildContext Function() getContext,
    dynamic params,
  ) async {
    final result = await apiService.post(endpoint, params);

    if (result != null) {
      return lsd
          .parseAction(Map<String, dynamic>.from(result))
          .perform(getContext, params);
    }
    return result;
  }
}
