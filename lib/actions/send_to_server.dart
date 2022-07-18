import 'package:lsd/lsd.dart';

import '../api_service.dart';
import '../components/screen_provider.dart';

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
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    final screenState = ScreenProvider.of(getContext());
    screenState.setBusy(true);
    Map<String, dynamic>? result;
    try {
      result = await apiService.post(endpoint, params);
    } finally {
      screenState.setBusy(false);
    }

    if (result != null) {
      return lsd
          .parseAction(Map<String, dynamic>.from(result))
          .perform(getContext, params);
    }
    return result;
  }
}
