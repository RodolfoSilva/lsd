import 'package:lsd/lsd.dart';

import '../api_service.dart';
import '../components/screen_provider.dart';

class SendToServerAction extends LsdAction {
  SendToServerAction(super.lsd, this.apiService);

  final ApiService apiService;
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
    final screenState = ScreenProvider.of(getContext());
    if (!silent) screenState.setBusy(true);
    Map<String, dynamic>? result;
    try {
      result = await apiService.post(endpoint, params);
    } finally {
      if (!silent) screenState.setBusy(false);
    }

    if (result != null) {
      return lsd
          .parseAction(Map<String, dynamic>.from(result))
          .perform(getContext, params);
    }
    return result;
  }
}
