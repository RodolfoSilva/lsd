import 'package:lsd/lsd.dart';

import '../api_service.dart';
import '../components/screen_provider.dart';

class GetFromServerAction extends LsdAction {
  GetFromServerAction(super.lsd, this.apiService);

  final ApiService apiService;
  late final String endpoint;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    endpoint = props["endpoint"];

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    final screenState = ScreenProvider.of(getContext());
    screenState.setBusy(true);
    Map<String, dynamic>? result;
    try {
      result = await apiService.get(endpoint);
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
