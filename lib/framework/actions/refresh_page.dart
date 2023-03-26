import 'package:lsd/lsd.dart';
import 'package:provider/provider.dart';

import '../controllers/screen_controller.dart';

class RefreshPageAction extends LsdAction {
  RefreshPageAction(super.lsd);

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    getContext().read<ScreenController>().refresh();
  }
}
