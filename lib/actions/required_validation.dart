import 'package:lsd/lsd.dart';

import '../lsd_form/lsd_validation_result.dart';

class RequiredValidationAction extends LsdAction {
  RequiredValidationAction(super.lsd);

  late String message;

  @override
  LsdAction fromJson(Map<String, dynamic> props) {
    message = props["message"] ?? "Required!";

    return super.fromJson(props);
  }

  @override
  Future<dynamic> perform(GetContext getContext, dynamic params) async {
    if (params is! String) {
      return LsdValidationResult.invalid("Invalid type");
    }

    if (params == "") {
      return LsdValidationResult.invalid(message);
    }

    return LsdValidationResult.valid();
  }
}
